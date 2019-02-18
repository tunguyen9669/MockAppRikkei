//
//  NewsRealmModel.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift

public class NewsRealmModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var feed: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var detailUrl: String = ""
    @objc dynamic var thumb: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var publishDate: String = ""
    @objc dynamic var creatTime: String = ""
    @objc dynamic var updateTime: String = ""
    
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
