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
    let realmManager = RealmManager.shared
    var events = [Event]()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.register(UINib(nibName: "DateHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateHeader")
        
        // get data from api
        self.getMyEvents(1) { (events) in
            self.creatDB(events: events)
            UserPrefsHelper.shared.setIsCallMyEventGoingAPI(true)
            self.getDataSourceTable(events)
        }
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countTap = 1
        if UserPrefsHelper.shared.getIsLoggined() == true {
            getDataCheckToday()
            getDataFromDB()
        }
       
    }
    
    // MARK: - function
    
    func getDataCheckToday() {
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            self.getMyEvents(1) { (events) in
                self.creatDB(events: events)
                UserPrefsHelper.shared.setIsCallMyEventGoingAPI(true)
                self.getDataSourceTable(events)
            }
            print("Load tu API")
        } else {
            //
        }
        
    }
    
    func getDataFromDB() {
        guard let arrEvent = realmManager.getObjects(EventRealmModel.self)?.filter("myStatus == 1").toArray(ofType: EventRealmModel.self) else {
            return
        }
        
        print("Load Going Event tu DB")
        var events = [Event]()
        for item in arrEvent {
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
            events.append(popular)
        }
        self.getDataSourceTable(events)
    }

    func creatDB(events: [Event]) {
        for item in events {
            let eventRealm = EventRealmModel()
            eventRealm.id = item.getId()
            eventRealm.status = item.getStatus().description
            eventRealm.photo = item.getPhoto()
            eventRealm.name = item.getName()
            eventRealm.descRaw = item.getDescRaw()
            eventRealm.descHtml = item.getDescHtml()
            eventRealm.permanent = item.getPermanent()
            eventRealm.dateWarning = item.getDateWarning()
            eventRealm.timeAlert = item.getTimeAlert()
            eventRealm.startDate = item.getStartDate()
            eventRealm.startTime = item.getStartTime()
            eventRealm.endDate = item.getEndDate()
            eventRealm.endTime = item.getEndTime()
            eventRealm.oneDayEvent = item.getOneDayEvent()
            eventRealm.extra = item.getExtra()
            eventRealm.myStatus = item.getMyStatus()
            eventRealm.goingCount = item.getGoingCount().description
            eventRealm.wentCount = item.getWentCount().description
            realmManager.editObject(eventRealm)
        }
    }
    
    func getDataSourceTable(_ events: [Event]) {
        var arr = [CommonTableModel]()
        var todayEvents = [Event]()
        var tomorrowEvents = [Event]()
        var thisWeekEvents = [Event]()
        var nextWeekEvents = [Event]()
        var thisMonthEvents = [Event]()
        var nextMonthEvents = [Event]()
        var latersEvents = [Event]()
        var tookPlaceEvents = [Event]()
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
        
        arr.append(CommonTableModel("Today", todayEvents))
        arr.append(CommonTableModel("Tomorrow", tomorrowEvents))
        arr.append(CommonTableModel("This week", thisWeekEvents))
        arr.append(CommonTableModel("Next week", nextWeekEvents))
        arr.append(CommonTableModel("This month", thisMonthEvents))
        arr.append(CommonTableModel("Next month", nextMonthEvents))
        arr.append(CommonTableModel("Later", latersEvents))
        arr.append(CommonTableModel("Took place", tookPlaceEvents))
        
        self.arrCommonTables = arr
        
        self.tableView.reloadData()
    }
    
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
        cell.customInit(indexList.getPhoto(), indexList.getName(), indexList.getDescHtml(), indexList.getStartDate(), indexList.getEndDate(), indexList.getGoingCount(), indexList.getPermanent(), 0)
        cell.delegate = self
        cell.id = arrCommonTables[indexPath.section].getEvents()[indexPath.row].getId()
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

// extension
extension GoingViewController: EventCellDelegate {
    func onClick(_ id: Int) {
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            eventDetailVC.id = id
            self.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
    
}

