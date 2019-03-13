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
    let noHeaderDatasource = NoHeaderTableViewDS()
    let headerDatasource = HeaderTableViewDataSource()
    
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
        self.tableView.contentOffset = .zero
        self.tableView.delegate = self
        noHeaderDatasource.arrEvent = self.events
        self.tableView.dataSource = noHeaderDatasource
        self.tableView.reloadData()
    }
    @IBAction func sortByDate(_ sender: Any) {
        dateTitle.textColor = UIColor.white
        popularTitle.textColor = UIColor.black
        indexStyle = 2
        self.tableView.contentOffset = .zero
        
        self.tableView.delegate = headerDatasource
        headerDatasource.arrCommonTables = self.arrCommonTables
        self.tableView.dataSource = headerDatasource
        self.tableView.reloadData()
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    var indexStyle = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(EventByCategoryViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.register(UINib(nibName: "DateHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DateHeader")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 300.0
        
        checkDataDB()
        notificationAction()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.delegate = self
            self.noHeaderDatasource.arrEvent = self.events
            self.tableView.dataSource = self.noHeaderDatasource
            self.tableView.reloadData()
        }
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(self.goDateTab(_:)))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(self.goPopularTab(_:)))
        right.direction = .right
        self.view.addGestureRecognizer(right)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataCheckIsToday()
       
        getDataFromDB()
        
    }
   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    @objc func goDateTab(_ sender: UISwipeGestureRecognizer) {
        dateTitle.textColor = UIColor.white
        popularTitle.textColor = UIColor.black
        indexStyle = 2
        self.tableView.contentOffset = .zero
        
        self.tableView.delegate = headerDatasource
        headerDatasource.arrCommonTables = self.arrCommonTables
        self.tableView.dataSource = headerDatasource
        self.tableView.reloadData()
    }
    @objc func goPopularTab(_ sender: UISwipeGestureRecognizer) {
        dateTitle.textColor = UIColor.black
        popularTitle.textColor = UIColor.white
        indexStyle = 1
        self.tableView.contentOffset = .zero
        self.tableView.delegate = self
        noHeaderDatasource.arrEvent = self.events
        self.tableView.dataSource = noHeaderDatasource
        self.tableView.reloadData()
    }
    
    func notificationAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(onGoing(_:)), name: .kUpdateGoingEvent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onWent(_:)), name: .kUpdateWentEvent, object: nil)
    }
    
    @objc func onGoing(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            var arr = events
            for i in 0..<self.events.count {
                if self.events[i].getId() == popular.getId() {
                    arr[i].myStatus = 1
                }
            }
            let categoryRealm = CategoryRealmModel()
            categoryRealm.id = self.category.getId()
            categoryRealm.name = self.category.getName()
            categoryRealm.slug = self.category.getSlug()
            categoryRealm.parentId = self.category.getParentId()
            for item in arr {
                let event = EventRealmModel(item)
                categoryRealm.events.append(event)
            }
            realmManager.editObject(categoryRealm)
            getDataFromDB()
            self.tableView.reloadData()
        }
    }
    
    @objc func onWent(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            var arr = events
            for i in 0..<self.events.count {
                if events[i].getId() == popular.getId() {
                    arr[i].myStatus = 2
                }
            }
            let categoryRealm = CategoryRealmModel()
            categoryRealm.id = self.category.getId()
            categoryRealm.name = self.category.getName()
            categoryRealm.slug = self.category.getSlug()
            categoryRealm.parentId = self.category.getParentId()
            for item in arr {
                let event = EventRealmModel(item)
                categoryRealm.events.append(event)
            }
            realmManager.editObject(categoryRealm)
            getDataFromDB()
            self.tableView.reloadData()
        }
        
    }
    
    
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    // refresh data
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataFromDB()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
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
    
    func editEvent(category: CategoryRealmModel) {
        realmManager.editObject(category)
    }
    
    func reloadTable(_ arr: [Event]) {
        self.events.removeAll()
        self.events += arr
        self.events = self.events.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        
        self.tableView.reloadData()
    }
    
    func checkDataDB() {
        // chua nghi ra truy van getobject
        guard let arrCategory = realmManager.getObjects(CategoryRealmModel.self)?.filter("id == \(self.category.getId())").toArray(ofType: CategoryRealmModel.self) else {
            return
        }
       

        var events = [EventRealmModel]()
        for item in arrCategory {
            events = Array(item.events)
        }
        print(events.count)
        
        if events.count == 0 {
            getEventsByCategory(1, self.category.getId()) { (events) in
                self.creatDB(populars: events)
                self.reloadTable(events)
                self.getDataSourceTable(events)
                self.titleLabel.text = "\(self.category.getName()) (\(events.count))"
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
            arr.append(Event(item))
        }
        print("Array: \(arr.count)")
        self.reloadTable(arr)
        self.getDataSourceTable(arr)
        self.titleLabel.text = "\(self.category.getName()) (\(arr.count))"
       
    }
    
    func creatDB(populars: [Event]) {
        let categoryRealm = CategoryRealmModel()
        categoryRealm.id = self.category.getId()
        categoryRealm.name = self.category.getName()
        categoryRealm.slug = self.category.getSlug()
        categoryRealm.parentId = self.category.getParentId()
        for item in populars {
            let event = EventRealmModel(item)
            categoryRealm.events.append(event)
        }
        print(categoryRealm.events.count)
        realmManager.editObject(categoryRealm)
        
        
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

extension EventByCategoryViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if indexStyle == 1 {
//            return events.count
//        }
//        return self.arrCommonTables[section].getEvents().count
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if indexStyle == 1 {
//            return
//            1
//        }
//        return self.arrCommonTables.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
//            return UITableViewCell()
//        }
//
//        cell.delegate = self
//        if indexStyle == 1 {
//            let photo = self.events[indexPath.row].getPhoto()
//            let name = self.events[indexPath.row].getName()
//            let startDate = self.events[indexPath.row].getStartDate()
//            let endDate = self.events[indexPath.row].getEndDate()
//            let descHtml = self.events[indexPath.row].getDescHtml()
//            let goingCount = self.events[indexPath.row].getGoingCount()
//            let permanent = self.events[indexPath.row].getPermanent()
//            let myStatus = self.events[indexPath.row].getMyStatus()
//            cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, myStatus)
//            cell.id = self.events[indexPath.row].getId()
//        } else {
//            let indexList = arrCommonTables[indexPath.section].getEvents()[indexPath.row]
//            cell.customInit(indexList.getPhoto(), indexList.getName(), indexList.getDescHtml(), indexList.getStartDate(), indexList.getEndDate(), indexList.getGoingCount(), indexList.getPermanent(), indexList.getStatus())
//            cell.id = arrCommonTables[indexPath.section].getEvents()[indexPath.row].getId()
//        }
//        return cell
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeader") as? DateHeader else {
//            return UITableViewHeaderFooterView()
//        }
//        header.customInit(arrCommonTables[section].getTitle())
//        if indexStyle == 1 {
//            header.isHidden = true
//        } else {
//            header.isHidden = false
//        }
//        return header
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more
        if Connectivity.isConnectedToInternet {
            if indexStyle == 1 {
                if indexPath.row == self.events.count - 1 {
                    print("load more")
                    if pageIndex < 20 {
                        self.pageIndex += 1
                    }
                    print(pageIndex)
                    
                    self.getEventsByCategory(self.pageIndex, self.category.getId()) { (events) in
                        var arr: [Event] = []
                        for item in events {
                            arr.append(item)
                        }
                        if arr.count > 0{
                            self.events += arr
                            self.creatDB(populars: self.events)
                            self.getDataSourceTable(self.events)
                            self.reloadTable(self.events)
                            self.noHeaderDatasource.arrEvent += arr
                            self.titleLabel.text = "\(self.category.getName()) (\(self.events.count))"
                        }
                    }
                    self.perform(#selector(self.loadTable), with: nil, afterDelay: 1.0)
                }
            } else {
                //
            }
            
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
        
    }
}
// extension
//extension EventByCategoryViewController: EventCellDelegate {
//    func onClick(_ id: Int) {
//        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
//            eventDetailVC.id = id
//            self.navigationController?.pushViewController(eventDetailVC, animated: true)
//        }
//    }

    
//}
