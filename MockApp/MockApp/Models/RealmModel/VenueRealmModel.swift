//
//  VenueRealmModel.swift
//  MockApp
//
//  Created by tund on 3/4/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift

class VenueRealmModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: Int = 0
    @objc dynamic var desc: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var area: String = ""
    @objc dynamic var long: Float = 0.0
    @objc dynamic var lat: Float = 0.0
    @objc dynamic var scheduleOpening: String = ""
    @objc dynamic var scheduleClosing: String = ""
    @objc dynamic var scheduleClosed: String = ""
   
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
