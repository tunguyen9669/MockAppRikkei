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
    let realmManager = MyEventsRealmManager()
    var events = [Event]()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.register(UINib(nibName: "DateHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateHeader")
        notificationAction()
        getData()
        getDataSourceTable(self.events)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countTap = 1
        getData()
        getDataSourceTable(self.events)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func getData() {
        // work with api
        self.events.removeAll()
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            self.getMyEvents(1) { (events) in
                print("Count Popular: \(events.count)")
                self.creatDB(events: events)
                self.events = events
                UserPrefsHelper.shared.setIsCallMyEventAPI(true)
            }
            print("Load tu API")
        } else {
            guard let arrEvent = realmManager.getObjects(EventRealmModel.self)?.filter("myStatus == 1").toArray(ofType: EventRealmModel.self) else {
                return
            }
            if arrEvent.count == 0 {
                self.getMyEvents(1) { (events) in
                    print("Count Popular: \(events.count)")
                    self.creatDB(events: events)
                    self.events = events
                    UserPrefsHelper.shared.setIsCallMyEventAPI(true)
                }
            } else {
                print("Load Going Event tu DB")
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
                    self.events.append(popular)
                }
            }
        }
    }
  

    
    // MARK: - function
    
    func creatDB(events: [Event]) {
        guard let arrEvent = realmManager.getObjects(EventRealmModel.self)?.filter("myStatus == 1").toArray(ofType: EventRealmModel.self) else {
            return
        }
        realmManager.deleteObjects(objs: arrEvent)
        for item in events {
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
            realmManager.editObject(obj: popular)
        }
        UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
    }
    
    func getDataSourceTable(_ events: [Event]) {
        self.arrCommonTables.removeAll()
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
    
    func notificationAction() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(onWent(_:)), name: .kUpdateWentEvent, object: nil)
        
    }
    
    @objc func onWent(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            // update table
            var arr = self.arrCommonTables
            for i in 0..<self.arrCommonTables.count {
                let events = arrCommonTables[i].getEvents()
                var newEvents = events
                for j in 0..<events.count {
                    if events[j].getId() == popular.getId() {
                        newEvents.remove(at: j)
                    }
                }
                arr[i].arrEvents = newEvents
            }
            self.arrCommonTables.removeAll()
            self.arrCommonTables = arr
            self.tableView.reloadData()
        }
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

