//
//  MyEventsRealmManager.swift
//  MockApp
//
//  Created by tund on 2/28/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class MyEventsRealmManager: NSObject {
    public static let shared = MyEventsRealmManager()
    override init() {
        //
    }
    func getObjects<Element: Object>(_ type: Element.Type) -> Results<Element>? {
        do {
            let realm = try Realm()
            return realm.objects(type)
        } catch let error as NSError {
            print(error.description)
        }
        return nil
    }
    func addObject(obj: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(obj)
                if let news = obj as? EventRealmModel {
                    realm.add(news)
                    print("Complete add Event")
                }
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    func deleteObject(obj: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(obj)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    func deleteObjects(objs: [Object]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(objs)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    func deleteDabase() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func editObject(_ event: Event) {
        
        let eventRealm = EventRealmModel()
        eventRealm.id = event.getId()
        eventRealm.status = event.getStatus().description
        eventRealm.photo = event.getPhoto()
        eventRealm.name = event.getName()
        eventRealm.descRaw = event.getDescRaw()
        eventRealm.descHtml = event.getDescHtml()
        eventRealm.permanent = event.getPermanent()
        eventRealm.dateWarning = event.getDateWarning()
        eventRealm.timeAlert = event.getTimeAlert()
        eventRealm.startDate = event.getStartDate()
        eventRealm.startTime = event.getStartTime()
        eventRealm.endDate = event.getEndDate()
        eventRealm.endTime = event.getEndTime()
        eventRealm.oneDayEvent = event.getOneDayEvent()
        eventRealm.extra = event.getExtra()
        eventRealm.myStatus = event.getMyStatus()
        eventRealm.goingCount = event.getGoingCount().description
        eventRealm.wentCount = event.getWentCount().description
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(eventRealm, update: true)
                print("Sửa thành công")
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
}

