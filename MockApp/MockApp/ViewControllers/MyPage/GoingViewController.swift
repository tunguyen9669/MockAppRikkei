//
//  GoingViewController.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class GoingViewController: UIViewController {
    // MARK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    var arrCommonTables = [CommonTableModel]()
    var countTap = 1
    let services = MyPageService()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.register(UINib(nibName: "DateHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateHeader")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         1: Today
         2: Tomorrow
         3: This week
         4: Next week
         5: This month
         6: Next month
         7: Later
         8: End
         */
        countTap = 1
        var todayEvents = [Event]()
        var tomorrowEvents = [Event]()
        var thisWeekEvents = [Event]()
        var nextWeekEvents = [Event]()
        var thisMonthEvents = [Event]()
        var nextMonthEvents = [Event]()
        var latersEvents = [Event]()
        var tookPlaceEvents = [Event]()
        
        // get Data from API
        self.getMyEvents(1) { (events) in
            print("Count Popular: \(events.count)")
            self.arrCommonTables.removeAll()
            for item in events {
                let date = "\(item.getEndDate()) \(item.getEndTime())".convertStringToMilisecond()
                print("Date: \(date)")
                print("Case: \(self.getTimeEndEvent(date))")
                switch self.getTimeEndEvent(date) {
                case 1:
                    todayEvents.append(item)
                case 2:
                    tomorrowEvents.append(item)
                case 3:
                    thisWeekEvents.append(item)
                case 4:
                    nextWeekEvents.append(item)
                case 5:
                    thisMonthEvents.append(item)
                case 6:
                    nextMonthEvents.append(item)
                case 7:
                    latersEvents.append(item)
                case 8:
                    tookPlaceEvents.append(item)
                default: break
                }
            }
            
            self.arrCommonTables.append(CommonTableModel("Today", todayEvents))
            self.arrCommonTables.append(CommonTableModel("Tomorrow", tomorrowEvents))
            self.arrCommonTables.append(CommonTableModel("This week", thisWeekEvents))
            self.arrCommonTables.append(CommonTableModel("Next week", nextWeekEvents))
            self.arrCommonTables.append(CommonTableModel("This month", thisMonthEvents))
            self.arrCommonTables.append(CommonTableModel("Next month", nextMonthEvents))
            self.arrCommonTables.append(CommonTableModel("Later", latersEvents))
            self.arrCommonTables.append(CommonTableModel("Took place", tookPlaceEvents))
            
            self.tableView.reloadData()
            
            
        }
        
        
        
    }
    
    // MARK: - function
    
    func getMyEvents(_ status: Int, _ completion: @escaping([Event]) -> Void) {
        if Connectivity.isConnectedToInternet == true {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetMyEvents(status) { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr: [Event] = []
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
    
}
// MARK: - extension
extension GoingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrCommonTables.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCommonTables[section].getEvents().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexList = arrCommonTables[indexPath.section].getEvents()[indexPath.row]
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        cell.customInit(indexList.getPhoto(), indexList.getName(), indexList.getDescHtml(), indexList.getStartDate(), indexList.getEndDate(), indexList.getGoingCount(), indexList.getPermanent(), indexList.getMyStatus())
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeader") as? DateHeader else {
            return UITableViewHeaderFooterView()
        }
        header.customInit(arrCommonTables[section].getTitle())
        return header
    }
    
    
}
