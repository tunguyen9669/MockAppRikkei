//
//  SearchViewController.swift
//  MockApp
//
//  Created by tund on 3/5/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - outlet, acion and variable
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var pastLabel: UILabel!
    
    var upcomingEvents = [Event]()
    var pastEvents = [Event]()
    @IBOutlet weak var tableView: UITableView!
    let services = BrowseService()
    var pageIndex = 1
    
    var indexStyle = 1
    
    var keyword: String = ""
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SearchViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    
    @IBAction func openUpcoming(_ sender: Any) {
        upcomingLabel.textColor = UIColor.white
        pastLabel.textColor = UIColor.black
        indexStyle = 1
        self.tableView.reloadData()
    }
    
    @IBAction func openPast(_ sender: Any) {
        upcomingLabel.textColor = UIColor.black
        pastLabel.textColor = UIColor.white
        indexStyle = 2
        self.tableView.reloadData()
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        //tap screen
        let onTapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(onTapViewGestureRecognizer)
        
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 300.0
        
    }
    
    // MARK: - function
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.search(1, self.keyword) { (arr) in
            self.upcomingEvents.removeAll()
            self.pastEvents.removeAll()
            self.updateDataSource(arr)
            self.tableView.reloadData()
        }
        
    }
    
    func search(_ pageIndex: Int, _ keyword: String, _ completion: @escaping ([Event]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestSearch(pageIndex, keyword) { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr = [Event]()
                    for item in result {
                        arr.append(Event(item))
                    }
                    completion(arr)
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                }
            }
        } else {
             self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
        
    }
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    func updateDataSource(_ arr: [Event]) {
        self.upcomingEvents += arr.filter { $0.getEndDate() != "" }
        self.upcomingEvents = self.upcomingEvents.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.pastEvents += arr.filter { $0.getEndDate() == "" }
        self.pastEvents = self.pastEvents.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.upcomingLabel.text = "Current & upcoming (\(self.upcomingEvents.count))"
        self.pastLabel.text = "Past (\(self.pastEvents.count))"
    }
}

// extension

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if indexStyle == 1 {
            return self.upcomingEvents.count
        } else {
            return self.pastEvents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UITableViewCell()
            
        }
        cell.delegate = self
        if indexStyle == 1 {
            let photo = self.upcomingEvents[indexPath.row].getPhoto()
            let name = self.upcomingEvents[indexPath.row].getName()
            let startDate = self.upcomingEvents[indexPath.row].getStartDate()
            let endDate = self.upcomingEvents[indexPath.row].getEndDate()
            let descHtml = self.upcomingEvents[indexPath.row].getDescHtml()
            let goingCount = self.upcomingEvents[indexPath.row].getGoingCount()
            let permanent = self.upcomingEvents[indexPath.row].getPermanent()
            let myStatus = self.upcomingEvents[indexPath.row].getMyStatus()
            cell.id = self.upcomingEvents[indexPath.row].getId()
            cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, 0)
        } else {
            let photo = self.pastEvents[indexPath.row].getPhoto()
            let name = self.pastEvents[indexPath.row].getName()
            let startDate = self.pastEvents[indexPath.row].getStartDate()
            let endDate = self.pastEvents[indexPath.row].getEndDate()
            let descHtml = self.pastEvents[indexPath.row].getDescHtml()
            let goingCount = self.pastEvents[indexPath.row].getGoingCount()
            let permanent = self.pastEvents[indexPath.row].getPermanent()
            let myStatus = self.pastEvents[indexPath.row].getMyStatus()
            cell.id = self.pastEvents[indexPath.row].getId()
            cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more
        if Connectivity.isConnectedToInternet {
            if indexPath.row == self.upcomingEvents.count - 1 || indexPath.row == self.pastEvents.count - 1 {
                print("load more")
                if pageIndex < 20 {
                    self.pageIndex += 1
                }
                
                self.search(self.pageIndex, self.keyword) { (events) in
                    self.updateDataSource(events)
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
    
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if let keyword = self.searchTextField.text {
            self.keyword = keyword
            self.search(1, keyword) { (arr) in
                self.upcomingEvents.removeAll()
                self.pastEvents.removeAll()
                self.updateDataSource(arr)
                self.tableView.contentOffset = .zero
                self.tableView.reloadData()
            }
        }
        
        return true
    }
}

extension SearchViewController: EventCellDelegate {
    func onClick(_ id: Int) {
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            eventDetailVC.id = id
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
    
}
