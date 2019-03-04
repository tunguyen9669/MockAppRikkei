//
//  RealmManager.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmManager: NSObject {
    public static let shared = RealmManager()
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
                print("Complete add Object")
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
    
    func editObject(_ obj: Object) {
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(obj, update: true)
                print("Complete edit object")
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
}
