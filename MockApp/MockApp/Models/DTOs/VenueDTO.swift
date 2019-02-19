//
//  VenueDTO.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON

class VenueDTO {
    public var id: Int?
    public var name: String?
    public var type: Int?
    public var desc: String?
    public var scheduleOpening: String?
    public var scheduleClosing: String?
    public var scheduleClosed: String?
    
    public func getId() -> Int {
        return id ?? 0
    }
    public func getName() -> String {
        return name ?? ""
    }
    public func getType() -> Int {
        return type ?? 0
    }
    public func getDesc() -> String {
        return desc ?? ""
    }
    public func getOpening() -> String {
        return scheduleOpening ?? ""
    }
    public func getClosing() -> String {
        return scheduleClosing ?? ""
    }
    public func getClosed() -> String {
        return scheduleClosed ?? ""
    }
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.type = json["type"].intValue
        self.desc = json["description"].stringValue
        self.scheduleOpening = json["schedule_openinghour"].stringValue
        self.scheduleClosing = json["schedule_closinghour"].stringValue
        self.scheduleClosed = json["schedule_closed"].stringValue
    }
}
