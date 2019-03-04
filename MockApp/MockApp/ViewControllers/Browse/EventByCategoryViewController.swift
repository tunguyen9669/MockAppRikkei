//
//  EventByCategoryViewController.swift
//  MockApp
//
//  Created by tund on 3/4/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EventByCategoryViewController: UIViewController {
    // MARK: - outlet, action and variable
    var category = Category()
    let services = BrowseService()
    let realmManager = RealmManager.shared
    var pageIndex = 1
    var events = [Event]()
    var arrCommonTables = [CommonTableModel]()
    
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sortByPopularity(_ sender: Any) {
        dateTitle.textColor = UIColor.black
        popularTitle.textColor = UIColor.white
        indexStyle = 1
        self.tableView.reloadData()
    }
    @IBAction func sortByDate(_ sender: Any) {
        dateTitle.textColor = UIColor.white
        popularTitle.textColor = UIColor.black
        indexStyle = 2
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    var indexStyle = 1
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.register(UINib(nibName: "DateHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateHeader")
        
        self.tableView.estimatedRowHeight = 300.0
        
        checkDataDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataCheckIsToday()
        getDataFromDB()

        
    }
    
    // MARK: - function
    
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
        self.tableView.contentOffset = .zero
        
    }
    
    func getDataCheckIsToday() {
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getEventsByCategory(1, self.category.getId()) { (events) in
                self.creatDB(populars: events)
            }
            print("Load tu API")
        } else {
            //
        }
    }
    
    func reloadTable(_ arr: [Event]) {
        self.events.removeAll()
        self.events += arr
        self.events = self.events.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.titleLabel.text = "\(self.category.getName()) (\(events.count))"
        self.tableView.contentOffset = .zero
    }
    
    func checkDataDB() {
        // chua nghi ra truy van getobject
        guard let arrCategory = realmManager.getObjects(CategoryRealmModel.self)?.filter("id == \(self.category.getId())").toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        if arrCategory.count == 0 {
            getEventsByCategory(1, self.category.getId()) { (events) in
                self.creatDB(populars: events)
                self.reloadTable(events)
                self.getDataSourceTable(events)
            }
        }
        
    }
    
    func getDataFromDB() {
        guard let arrCategory = realmManager.getObjects(CategoryRealmModel.self)?.filter("id == \(self.category.getId())").toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        var events = [EventRealmModel]()
        for item in arrCategory {
             events = Array(item.events)
        }
        // update index for load more
        self.pageIndex = events.count / 10
        
        var arr = [Event]()
        
        print("Load từ event DB")
        for item in events {
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
            popular.venue = Venue(item.getVenue().id, item.getVenue().name, item.getVenue().type, item.getVenue().desc, item.getVenue().area, item.getVenue().address, item.getVenue().lat, item.getVenue().long, item.getVenue().scheduleOpening, item.getVenue().scheduleClosing, item.getVenue().scheduleClosed)
            arr.append(popular)
        }
        self.reloadTable(arr)
        self.getDataSourceTable(arr)
    }
    
    func creatDB(populars: [Event]) {
        let categoryRealm = CategoryRealmModel()
        categoryRealm.id = self.category.getId()
        categoryRealm.name = self.category.getName()
        categoryRealm.slug = self.category.getSlug()
        categoryRealm.parentId = self.category.getParentId()
        for item in populars {
            let event = self.parseToRealm(event: item)
            categoryRealm.events.append(event)
        }
        print(categoryRealm.events.count)
        realmManager.editObject(categoryRealm)
        
    }
    func parseToRealm(event: Event) -> EventRealmModel {
        let popular = EventRealmModel()
        popular.id = event.getId()
        popular.status = event.getStatus().description
        popular.photo = event.getPhoto()
        popular.name = event.getName()
        popular.descRaw = event.getDescRaw()
        popular.descHtml = event.getDescHtml()
        popular.permanent = event.getPermanent()
        popular.dateWarning = event.getDateWarning()
        popular.timeAlert = event.getTimeAlert()
        popular.startDate = event.getStartDate()
        popular.startTime = event.getStartTime()
        popular.endDate = event.getEndDate()
        popular.endTime = event.getEndTime()
        popular.oneDayEvent = event.getOneDayEvent()
        popular.extra = event.getExtra()
        popular.myStatus = event.getMyStatus()
        popular.goingCount = event.getGoingCount().description
        popular.wentCount = event.getWentCount().description
        popular.getVenue().id = event.venue.getId()
        popular.getVenue().name = event.venue.getName()
        popular.getVenue().type = event.venue.getType()
        popular.getVenue().desc = event.venue.getDesc()
        popular.getVenue().area = event.venue.getArea()
        popular.getVenue().address = event.venue.getAdress()
        popular.getVenue().lat = event.venue.getLat()
        popular.getVenue().long = event.venue.getLong()
        popular.getVenue().scheduleOpening = event.venue.getOpening()
        popular.getVenue().scheduleClosing = event.venue.getClosing()
        popular.getVenue().scheduleClosed = event.venue.getClosed()
        
        return popular
    }
    
    func getEventsByCategory(_ pageIndex: Int, _ id: Int, _ conpletion: @escaping([Event]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetListEventsByCT(pageIndex, id) { (result) in
                switch result {
                case .success(let result):
                    var arr = [Event]()
                    for item in result {
                        arr.append(Event(item))
                    }
                    conpletion(arr)
                    
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

// extension

extension EventByCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if indexStyle == 1 {
            return events.count
        }
        return self.arrCommonTables[section].getEvents().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if indexStyle == 1 {
            return
            1
        }
        return self.arrCommonTables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeader") as? DateHeader else {
            return UITableViewHeaderFooterView()
        }
        header.customInit(arrCommonTables[section].getTitle())
        if indexStyle == 1 {
            header.isHidden = true
        } else {
            header.isHidden = false
        }
        return header
    }
    
    
}
