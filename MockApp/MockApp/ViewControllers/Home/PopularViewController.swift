//
//  PopularViewController.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class PopularViewController: UIViewController {
    //MARLK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    
    let services = HomeService()
    var populars = [Popular]()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
       
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPopularList(1) { (populars) in
            for item in populars {
                self.populars.append(item)
            }
            self.reloadTable()
        }
    }
    
    // MARK: - function
    
    func getPopularList(_ pageIndex: Int, _ completion: @escaping([Popular]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetPopularEvents(pageIndex, completion: { (result) in
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
            })
        } else {
            AppDelegate.shared.tabbar?.alertWith("Thông báo", "Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
    
    func reloadTable() {
//        self.populars = self.populars.sorted { (news1, news2) -> Bool in
//            return news1.getPublishDate().convertStringToMilisecond() >= news2.getPublishDate().convertStringToMilisecond()
//        }
        self.tableView.reloadData()
    }
}

// MARK: - extension
extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.populars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularCell else {
            return UITableViewCell()
            
        }
        let photo = populars[indexPath.row].getPhoto()
        let name = populars[indexPath.row].getName()
        let startDate = populars[indexPath.row].getStartDate()
        let endDate = populars[indexPath.row].getEndDate()
        let descHtml = populars[indexPath.row].getDescHtml()
        let goingCount = populars[indexPath.row].getGoingCount()
        let permanent = populars[indexPath.row].getPermanent()
        
        cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent)
        return cell
    }
    
    
}
