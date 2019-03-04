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
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEventsByCategory(1, self.category.getId()) { (events) in
            self.titleLabel.text = "\(self.category.getName()) (\(events.count))"
            self.creatDB(populars: events)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getDataCheckIsToday()
//        checkDataDB()
        getEventsByCategory(1, self.category.getId()) { (events) in
            self.titleLabel.text = "\(self.category.getName()) (\(events.count))"
            self.creatDB(populars: events)
        }
//        getDataFromDB()

        
    }
    
    // MARK: - function
    
    func getDataCheckIsToday() {
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getEventsByCategory(1, self.category.getId()) { (events) in
                self.titleLabel.text = "\(self.category.getName()) (\(events.count))"
                self.creatDB(populars: events)
            }
            print("Load tu API")
        } else {
            //
        }
    }
    
    func checkDataDB() {
        // chua nghi ra truy van getobject
        guard let arrCategory = realmManager.getObjects(CategoryRealmModel.self)?.filter("id == \(self.category.getId())").toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        
       print(arrCategory.count)
        
    }
    
    func getDataFromDB() {
        guard let arr = realmManager.getObjects(CategoryRealmModel.self)?.filter("id == \(self.category.getId())").toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        for item in arr {
             print("Event: \(item.events.count)")
        }
        
        
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
