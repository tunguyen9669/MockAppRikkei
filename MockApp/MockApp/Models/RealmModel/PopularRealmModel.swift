//
//  PopularRealmModel.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift

public class PopularRealmModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var descRaw: String = ""
    @objc dynamic var descHtml: String = ""
    @objc dynamic var permanent: String = ""
    @objc dynamic var dateWarning: String = ""
    @objc dynamic var timeAlert: String = ""
    @objc dynamic var startDate: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endDate: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var oneDayEvent: String = ""
    @objc dynamic var extra: String = ""
    @objc dynamic var goingCount: String = ""
    @objc dynamic var wentCount: String = ""
//    @objc dynamic var venue = Venue()
 
    override public static func primaryKey() -> String? {
        return "id"
    }
}

