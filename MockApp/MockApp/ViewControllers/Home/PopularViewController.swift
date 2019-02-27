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
    
    
    var popular = Popular()
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
        appDelegate.tabbar?.setHidden(false)
        getData()
        notificationAction()
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.pageIndex = 1
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func notificationAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .kLogout, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGetNewData(_:)), name: .kLogin, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGoing(_:)), name: .kUpdateGoingEvent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onWent(_:)), name: .kUpdateWentEvent, object: nil)
       
    }
    
    
    @objc func onWent(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Popular {
//            let popularRealm = PopularRealmModel()
//            popularRealm.id = popular.getId().description
//            popularRealm.status = popular.getStatus().description
//            popularRealm.photo = popular.getPhoto()
//            popularRealm.name = popular.getName()
//            popularRealm.descRaw = popular.getDescRaw()
//            popularRealm.descHtml = popular.getDescHtml()
//            popularRealm.permanent = popular.getPermanent()
//            popularRealm.dateWarning = popular.getDateWarning()
//            popularRealm.timeAlert = popular.getTimeAlert()
//            popularRealm.startDate = popular.getStartDate()
//            popularRealm.startTime = popular.getStartTime()
//            popularRealm.endDate = popular.getEndDate()
//            popularRealm.endTime = popular.getEndTime()
//            popularRealm.oneDayEvent = popular.getOneDayEvent()
//            popularRealm.extra = popular.getExtra()
//            popularRealm.myStatus = 2
//            popularRealm.goingCount = popular.getGoingCount().description
//            popularRealm.wentCount = popular.getWentCount().description
//            realmManager.editObject(obj: popularRealm)
            
            // update table
            var arr = self.populars
            for i in 0..<self.populars.count {
                if self.populars[i].getId() == popular.getId() {
                    arr[i].myStatus = 2
                }
            }
            self.populars.removeAll()
            self.populars = arr
            self.tableView.reloadData()
        }
    }
    
    
    @objc func onGoing(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Popular {
//            let popularRealm = PopularRealmModel()
//            popularRealm.id = popular.getId().description
//            popularRealm.status = popular.getStatus().description
//            popularRealm.photo = popular.getPhoto()
//            popularRealm.name = popular.getName()
//            popularRealm.descRaw = popular.getDescRaw()
//            popularRealm.descHtml = popular.getDescHtml()
//            popularRealm.permanent = popular.getPermanent()
//            popularRealm.dateWarning = popular.getDateWarning()
//            popularRealm.timeAlert = popular.getTimeAlert()
//            popularRealm.startDate = popular.getStartDate()
//            popularRealm.startTime = popular.getStartTime()
//            popularRealm.endDate = popular.getEndDate()
//            popularRealm.endTime = popular.getEndTime()
//            popularRealm.oneDayEvent = popular.getOneDayEvent()
//            popularRealm.extra = popular.getExtra()
//            popularRealm.myStatus = 1
//            popularRealm.goingCount = popular.getGoingCount().description
//            popularRealm.wentCount = popular.getWentCount().description
//            realmManager.editObject(obj: popularRealm)
            
            
            // update table
            var arr = self.populars
            for i in 0..<self.populars.count {
                if self.populars[i].getId() == popular.getId() {
                    arr[i].myStatus = 1
                }
            }
            self.populars.removeAll()
            self.populars = arr
            self.tableView.reloadData()
            
        }
        
    }
    @objc func onLogout(_ sender: Notification) {
        self.populars.removeAll()
        print("Update status")
        getPopularList(1) { (populars) in
            self.creatDB(populars: populars)
            self.populars = populars
            print("Popular count: \(populars.count)")
            
            self.reloadTable()
        }
    }
    
    @objc func onGetNewData(_ sender: Notification) {
        // notification center
        self.populars.removeAll()
        print("Update status")
        getPopularList(1) { (populars) in
            self.creatDB(populars: populars)
            self.populars = populars
            print("Popular count: \(populars.count)")
            
            self.reloadTable()
        }
        
        let firstIndexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: firstIndexPath as IndexPath, animated: true, scrollPosition: .top)
    }
    
    func getData() {
        // work with api
        self.populars.removeAll()
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            self.populars.removeAll()
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
    }
    
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
        UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
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
                    self.alertWith("Fail get data")
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
            let photo = self.populars[indexPath.row].getPhoto()
            let name = self.populars[indexPath.row].getName()
            let startDate = self.populars[indexPath.row].getStartDate()
            let endDate = self.populars[indexPath.row].getEndDate()
            let descHtml = self.populars[indexPath.row].getDescHtml()
            let goingCount = self.populars[indexPath.row].getGoingCount()
            let permanent = self.populars[indexPath.row].getPermanent()
            let myStatus = self.populars[indexPath.row].getMyStatus()
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
                
                guard let arrPopular = realmManager.getObjects(PopularRealmModel.self)?.toArray(ofType: PopularRealmModel.self) else {
                    return
                }
                
                self.getPopularList(pageIndex) { (populars) in
                    
                    var arr: [Popular] = []
                    for item in populars {
                        arr.append(item)
                    }
//                    for item in arr {
//                        let popular = PopularRealmModel()
//                        popular.id = item.getId().description
//                        popular.status = item.getStatus().description
//                        popular.photo = item.getPhoto()
//                        popular.name = item.getName()
//                        popular.descRaw = item.getDescRaw()
//                        popular.descHtml = item.getDescHtml()
//                        popular.permanent = item.getPermanent()
//                        popular.dateWarning = item.getDateWarning()
//                        popular.timeAlert = item.getTimeAlert()
//                        popular.startDate = item.getStartDate()
//                        popular.startTime = item.getStartTime()
//                        popular.endDate = item.getEndDate()
//                        popular.endTime = item.getEndTime()
//                        popular.oneDayEvent = item.getOneDayEvent()
//                        popular.extra = item.getExtra()
//                        popular.myStatus = item.getMyStatus()
//                        popular.goingCount = item.getGoingCount().description
//                        popular.wentCount = item.getWentCount().description
//                        self.realmManager.addObject(obj: popular)
//                    }
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
            eventDetailVC.id = populars[indexPath.row].getId()
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
}
