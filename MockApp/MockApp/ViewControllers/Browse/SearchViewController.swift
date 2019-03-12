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
    let dataSource = NoHeaderTableViewDS()
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
        dataSource.arrEvent = upcomingEvents
        self.tableView.reloadData()
    }
    
    @IBAction func openPast(_ sender: Any) {
        upcomingLabel.textColor = UIColor.black
        pastLabel.textColor = UIColor.white
        indexStyle = 2
        dataSource.arrEvent = pastEvents
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
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
        
        notificationAction()
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func notificationAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(onGoing(_:)), name: .kUpdateGoingEvent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onWent(_:)), name: .kUpdateWentEvent, object: nil)
    }
    
    @objc func onGoing(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            if indexStyle == 1 {
                self.upcomingEvents = updateStatusTable(popular, 1, self.upcomingEvents)
            } else {
                 self.pastEvents = updateStatusTable(popular, 1, self.pastEvents)
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func onWent(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            if indexStyle == 1 {
                self.upcomingEvents = updateStatusTable(popular, 2, self.upcomingEvents)
            } else {
                self.pastEvents = updateStatusTable(popular, 2, self.pastEvents)
            }
             self.tableView.reloadData()
        }
        
    }
    
    func updateStatusTable(_ event: Event, _ status: Int,_ events: [Event]) -> [Event] {
        var arr = events
        for i in 0..<events.count {
            if upcomingEvents[i].getId() == event.getId() {
                arr[i].myStatus = status
            }
        }
        arr = arr.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        
        return arr
    }
    
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
        refreshControl.endRefreshing()
        
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
        if indexStyle == 1 {
            dataSource.arrEvent = self.upcomingEvents
        } else {
            dataSource.arrEvent = self.pastEvents
        }
    }
}

// extension
extension SearchViewController: UITableViewDelegate {
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

