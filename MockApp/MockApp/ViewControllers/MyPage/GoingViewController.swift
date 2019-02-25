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
        countTap = 1
        let popular = Popular()
        let populars = [popular]
        let populars1 = [popular, popular]
        self.arrCommonTables.append(CommonTableModel("Today", populars1))
        self.arrCommonTables.append(CommonTableModel("Tomorrow", populars))
        self.arrCommonTables.append(CommonTableModel("This week", populars))
        self.arrCommonTables.append(CommonTableModel("Next week", populars))
        self.arrCommonTables.append(CommonTableModel("This month", populars))
        self.arrCommonTables.append(CommonTableModel("Next month", populars))
        self.arrCommonTables.append(CommonTableModel("Later", populars))
        
        // get Data from API
        self.getMyEvents(1) { (populars) in
            print("Count Popular: \(populars.count)")
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeader") as? DateHeader else {
            return UITableViewHeaderFooterView()
        }
        return header
    }
    
    
}
