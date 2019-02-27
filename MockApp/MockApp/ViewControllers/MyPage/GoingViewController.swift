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
        self.tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
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
        var todayPopulars = [Popular]()
        var tomorrowPopulars = [Popular]()
        var thisWeekPopulars = [Popular]()
        var nextWeekPopulars = [Popular]()
        var thisMonthPopulars = [Popular]()
        var nextMonthPopulars = [Popular]()
        var latersPopulars = [Popular]()
        var tookPlacePopulars = [Popular]()
        
        // get Data from API
        self.getMyEvents(1) { (populars) in
            print("Count Popular: \(populars.count)")
            self.arrCommonTables.removeAll()
            for item in populars {
                let date = "\(item.getEndDate()) \(item.getEndTime())".convertStringToMilisecond()
                print("Date: \(date)")
                print("Case: \(self.getTimeEndEvent(date))")
                switch self.getTimeEndEvent(date) {
                case 1:
                    todayPopulars.append(item)
                case 2:
                    tomorrowPopulars.append(item)
                case 3:
                    thisWeekPopulars.append(item)
                case 4:
                    nextWeekPopulars.append(item)
                case 5:
                    thisMonthPopulars.append(item)
                case 6:
                    nextMonthPopulars.append(item)
                case 7:
                    latersPopulars.append(item)
                case 8:
                    tookPlacePopulars.append(item)
                default: break
                }
            }
            
            self.arrCommonTables.append(CommonTableModel("Today", todayPopulars))
            self.arrCommonTables.append(CommonTableModel("Tomorrow", tomorrowPopulars))
            self.arrCommonTables.append(CommonTableModel("This week", thisWeekPopulars))
            self.arrCommonTables.append(CommonTableModel("Next week", nextWeekPopulars))
            self.arrCommonTables.append(CommonTableModel("This month", thisMonthPopulars))
            self.arrCommonTables.append(CommonTableModel("Next month", nextMonthPopulars))
            self.arrCommonTables.append(CommonTableModel("Later", latersPopulars))
            self.arrCommonTables.append(CommonTableModel("Took place", tookPlacePopulars))
            
            self.tableView.reloadData()
            
            
        }
        
        
        
    }
    
    // MARK: - function
    
    func getMyEvents(_ status: Int, _ completion: @escaping([Popular]) -> Void) {
        if Connectivity.isConnectedToInternet == true {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetMyEvents(status) { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr: [Popular] = []
                    for item in result {
                        arr.append(Popular(item))
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
        return self.arrCommonTables[section].getPopulars().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexList = arrCommonTables[indexPath.section].getPopulars()[indexPath.row]
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularCell else {
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
