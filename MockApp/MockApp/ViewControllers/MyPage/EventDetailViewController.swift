//
//  EventDetailViewController.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController {
   
    // MARK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    
    var popular = Popular()
    var id: Int?
    var arrEDs = [EDModel]()
    let services = HomeService()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.tabbar?.setHidden(true)
        self.arrEDs.append(EDModel("first"))
        self.arrEDs.append(EDModel("second"))
        self.arrEDs.append(EDModel("third"))
        self.tableView.register(UINib(nibName: "FirstEDCell", bundle: nil), forCellReuseIdentifier: "FirstEDCell")
        self.tableView.register(UINib(nibName: "SecondEDCell", bundle: nil), forCellReuseIdentifier: "SecondEDCell")
        self.tableView.register(UINib(nibName: "ThirdEDCell", bundle: nil), forCellReuseIdentifier: "ThirdEDCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = self.id {
            getDetailEvent(id)
        }
        
    }
    
    func getDetailEvent(_ id: Int) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetDetailEvent(id) { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    self.popular = Popular(result)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                    self.alertWith("Fail get data")
                }
            }
            
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
    
}
// MARK: - extension
extension EventDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let id = self.id else {
            return UITableViewCell()
        }
        let photo = popular.getPhoto()
        let title = popular.getName()
        let location = popular.venue.getAdress()
        let date = popular.getEndDate()
        let goingCount = popular.getGoingCount()
        let venueName = popular.venue.getArea()
        let gentre = popular.venue.getDesc()
        
        if self.arrEDs[indexPath.row].getIdentifier() == "first" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstEDCell", for: indexPath) as? FirstEDCell else {
                return UITableViewCell()
            }
            cell.customInit(title, photo, "", date, goingCount, location)
            cell.delegate = self
            return cell
        } else if self.arrEDs[indexPath.row].getIdentifier() == "second" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondEDCell", for: indexPath) as? SecondEDCell else {
                return UITableViewCell()
            }
            cell.customInit(venueName, gentre, location, "", "")
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdEDCell", for: indexPath) as? ThirdEDCell else {
                return UITableViewCell()
            }
            cell.customInit(id)
            cell.delegate = self
            return cell
        }
    }
    
    
}
// first cell delegate
extension EventDetailViewController: FirstEDCellDelegate {
    func onClose() {
        self.navigationController?.popViewController(animated: true)
    }
}

// second cell delegate
extension EventDetailViewController: SecondEDCellDelegate {
    func onFollow() {
        if UserPrefsHelper.shared.getIsLoggined() == false {
            if let registerVC = R.storyboard.myPage.registerViewController() {
                appDelegate.tabbar?.selectedIndex = 3
            }
        } else {
            //
        }
    }
}

// third cell delegate
extension EventDetailViewController: ThirđEDCellDelegate {
    func sendIdItem(_ id: Int) {
        self.id = id
        let firstIndexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: firstIndexPath as IndexPath, animated: true, scrollPosition: .top)
        self.tableView.reloadData()
    }
    
    func onGoing() {
        if UserPrefsHelper.shared.getIsLoggined() == false {
            if let registerVC = R.storyboard.myPage.registerViewController() {
                appDelegate.tabbar?.selectedIndex = 3          
            }
        } else {
            
        }
    }
    
    func onWent() {
        if UserPrefsHelper.shared.getIsLoggined() == false {
            if let registerVC = R.storyboard.myPage.registerViewController() {
                appDelegate.tabbar?.selectedIndex = 3
            }
        } else {
            //
        }
    }
    
    
}
