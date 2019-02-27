//
//  PopularRealmManager.swift
//  MockApp
//
//  Created by tund on 2/20/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class PopularRealmManager: NSObject {
    public static let shared = PopularRealmManager()
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
                if let news = obj as? PopularRealmModel {
                    realm.add(news)
                    print("Complete add Popular")
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
    
    func editObject(obj: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(obj, update: true)
                print("Sửa thành công")
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
}

