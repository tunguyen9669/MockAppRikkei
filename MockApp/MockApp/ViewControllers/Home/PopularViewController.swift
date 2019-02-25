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
    let realmManager = PopularRealmManager.shared
    var pageIndex = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PopularViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 300.0
        self.tableView.delegate = self
       
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appDelegate.tabbar?.setHidden(false)
        
        self.populars.removeAll()
        
        let token = UserPrefsHelper.shared.getUserToken()
        
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
       
        if keyUpdate.isToday() == false {
            self.populars.removeAll()
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                self.populars = populars
                self.reloadTable()
            }
            print("Load tu API")
        } else {
            guard let arrPopular = realmManager.getObjects(PopularRealmModel.self)?.toArray(ofType: PopularRealmModel.self) else {
                return
            }
            if token != "" {
                print("Update API")
                self.populars.removeAll()
                UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
                getPopularList(1) { (populars) in
                    self.creatDB(populars: populars)
                    self.populars = populars
                    self.reloadTable()
                }
            } else {
                if arrPopular.count == 0 {
                    getPopularList(1) { (populars) in
                        self.creatDB(populars: populars)
                        self.populars = populars
                        self.reloadTable()
                    }
                } else {
                    print("Load tu DB")
                    for item in arrPopular {
                        let popular = Popular()
                        popular.id = Int(item.id)
                        popular.status = Int(item.status)
                        popular.photo = item.photo
                        popular.name = item.name
                        popular.descRaw = item.descRaw
                        popular.descHtml = item.descHtml
                        popular.permanent = item.permanent
                        popular.dateWarning = item.dateWarning
                        popular.timeAlert = item.timeAlert
                        popular.startDate = item.startDate
                        popular.startTime = item.startTime
                        popular.endDate = item.endDate
                        popular.endTime = item.endTime
                        popular.oneDayEvent = item.oneDayEvent
                        popular.extra = item.extra
                        popular.myStatus = item.myStatus
                        popular.goingCount = Int(item.goingCount)
                        popular.wentCount = Int(item.wentCount)
                        self.populars.append(popular)
                    }
                    self.reloadTable()
                }
            }
//            if arrPopular.count == 0 {
//                getPopularList(1) { (populars) in
//                    self.creatDB(populars: populars)
//                    self.populars = populars
//                    self.reloadTable()
//                }
//            } else {
//                print("Load tu DB")
//                for item in arrPopular {
//                    let popular = Popular()
//                    popular.id = Int(item.id)
//                    popular.status = Int(item.status)
//                    popular.photo = item.photo
//                    popular.name = item.name
//                    popular.descRaw = item.descRaw
//                    popular.descHtml = item.descHtml
//                    popular.permanent = item.permanent
//                    popular.dateWarning = item.dateWarning
//                    popular.timeAlert = item.timeAlert
//                    popular.startDate = item.startDate
//                    popular.startTime = item.startTime
//                    popular.endDate = item.endDate
//                    popular.endTime = item.endTime
//                    popular.oneDayEvent = item.oneDayEvent
//                    popular.extra = item.extra
//                    popular.goingCount = Int(item.goingCount)
//                    popular.wentCount = Int(item.wentCount)
//                    self.populars.append(popular)
//                }
//                self.reloadTable()
//            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.pageIndex = 1
    }
    
    // MARK: - function
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pageIndex = 1
        guard let arrPopular = realmManager.getObjects(PopularRealmModel.self)?.toArray(ofType: PopularRealmModel.self) else {
            return
        }
        self.populars.removeAll()
        if arrPopular.count == 0 {
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                self.populars = populars
                self.reloadTable()
            }
        } else {
            print("Load tu DB")
            for item in arrPopular {
                let popular = Popular()
                popular.id = Int(item.id)
                popular.status = Int(item.status)
                popular.photo = item.photo
                popular.name = item.name
                popular.descRaw = item.descRaw
                popular.descHtml = item.descHtml
                popular.permanent = item.permanent
                popular.dateWarning = item.dateWarning
                popular.timeAlert = item.timeAlert
                popular.startDate = item.startDate
                popular.startTime = item.startTime
                popular.endDate = item.endDate
                popular.endTime = item.endTime
                popular.oneDayEvent = item.oneDayEvent
                popular.extra = item.extra
                popular.myStatus = item.myStatus
                popular.goingCount = Int(item.goingCount)
                popular.wentCount = Int(item.wentCount)
                self.populars.append(popular)
            }
            self.reloadTable()
        }
        refreshControl.endRefreshing()
        
    }
    
    func creatDB(populars: [Popular]) {
        realmManager.deleteDabase()
        for item in populars {
            let popular = PopularRealmModel()
            popular.id = item.getId().description
            popular.status = item.getStatus().description
            popular.photo = item.getPhoto()
            popular.name = item.getName()
            popular.descRaw = item.getDescRaw()
            popular.descHtml = item.getDescHtml()
            popular.permanent = item.getPermanent()
            popular.dateWarning = item.getDateWarning()
            popular.timeAlert = item.getTimeAlert()
            popular.startDate = item.getStartDate()
            popular.startTime = item.getStartTime()
            popular.endDate = item.getEndDate()
            popular.endTime = item.getEndTime()
            popular.oneDayEvent = item.getOneDayEvent()
            popular.extra = item.getExtra()
            popular.myStatus = item.getMyStatus()
            popular.goingCount = item.getGoingCount().description
            popular.wentCount = item.getWentCount().description
            realmManager.addObject(obj: popular)
        }
    }
    
    func reloadTable() {
        self.populars = self.populars.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.tableView.reloadData()
    }
    
   
    
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
           self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
    @objc func loadTable() {
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
        let myStatus = populars[indexPath.row].getMyStatus()
        
        cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, myStatus)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more
        if Connectivity.isConnectedToInternet {
            if indexPath.row == self.populars.count - 1 {
                print("load more")
                if pageIndex < 20 {
                    self.pageIndex += 1
                }
                self.getPopularList(pageIndex) { (populars) in
                    var arr: [Popular] = []
                    for item in populars {
                        arr.append(item)
                    }
                    self.populars += arr
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)

            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click")
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
}
