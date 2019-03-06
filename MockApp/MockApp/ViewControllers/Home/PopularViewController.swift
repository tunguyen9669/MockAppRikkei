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
    
    
    var popular = Event()
    let services = HomeService()
    var populars = [Event]()
    let realmManager = RealmManager.shared
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
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 300.0
        self.tableView.delegate = self
        appDelegate.tabbar?.setHidden(false)
        notificationAction()
        checkDataDB()
        
       
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataCheckToday()
        getDataFromDB()
   
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func checkDataDB() {
        print("check data in db")
        guard let arrPopular = realmManager.getObjects(EventRealmModel.self)?.toArray(ofType: EventRealmModel.self) else {
            return
        }
        if arrPopular.count == 0 {
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                self.reloadTable(populars)
            }
        }
        
        // get data from API
   
    }
    
    func notificationAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .kLogout, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onGetNewData(_:)), name: .kLogin, object: nil)
        
       
    }
    
    @objc func onLogout(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Update status")
            self.getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                print("Popular count: \(populars.count)")
                
                self.reloadTable(populars)
            }
            
        }
     
    }
    
    @objc func onGetNewData(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Update status")
            self.getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                print("Popular count: \(populars.count)")
                self.reloadTable(populars)
            }
        }
    }
    
    func getDataCheckToday() {
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
            }
            print("Load từ  Popular API")
        } else {
            //
        }
    }
    func getDataFromDB() {
        guard let arrPopular = realmManager.getObjects(EventRealmModel.self)?.toArray(ofType: EventRealmModel.self) else {
            return
        }
        
        // update index for load more
        self.pageIndex = arrPopular.count / 10
        
        var arr = [Event]()
        
        print("Load từ event DB")
        for item in arrPopular {
            let popular = Event()
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
            popular.venue = Venue(item.getVenue().id, item.getVenue().name, item.getVenue().type, item.getVenue().desc, item.getVenue().area, item.getVenue().address, item.getVenue().lat.description, item.getVenue().long.description, item.getVenue().scheduleOpening, item.getVenue().scheduleClosing, item.getVenue().scheduleClosed)
            arr.append(popular)
        }
        self.reloadTable(arr)
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataFromDB()
        refreshControl.endRefreshing()
        
    }
    
    func creatDB(populars: [Event]) {
        for item in populars {
            let popular = EventRealmModel()
            popular.id = item.getId()
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
            popular.getVenue().id = item.venue.getId()
            popular.getVenue().name = item.venue.getName()
            popular.getVenue().type = item.venue.getType()
            popular.getVenue().desc = item.venue.getDesc()
            popular.getVenue().area = item.venue.getArea()
            popular.getVenue().address = item.venue.getAdress()
            popular.getVenue().lat = item.venue.getLat()
            popular.getVenue().long = item.venue.getLong()
            popular.getVenue().scheduleOpening = item.venue.getOpening()
            popular.getVenue().scheduleClosing = item.venue.getClosing()
            popular.getVenue().scheduleClosed = item.venue.getClosed()
            realmManager.editObject(popular)
        }
        
    }
    
    func reloadTable(_ arr: [Event]) {
        self.populars.removeAll()
        self.populars += arr
        self.populars = self.populars.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.tableView.reloadData()
        self.tableView.contentOffset = .zero
    }
    
    
    func getPopularList(_ pageIndex: Int, _ completion: @escaping([Event]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetPopularEvents(pageIndex, completion: { (result) in
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
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
            cell.delegate = self
            cell.id = populars[indexPath.row].getId()
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
                    
                    var arr: [Event] = []
                    for item in populars {
                        arr.append(item)
                    }
                    self.populars += arr
                    self.creatDB(populars: self.populars)
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
         } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
}

extension PopularViewController: EventCellDelegate {
    func onClick(_ id: Int) {
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            eventDetailVC.id = id
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
    
}
