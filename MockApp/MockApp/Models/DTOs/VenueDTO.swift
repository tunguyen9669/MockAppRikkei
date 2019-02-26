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
    public var address: String?
    public var area: String?
    public var long: Float?
    public var lat: Float?
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
    public func getAdress() -> String {
        return address ?? ""
    }
    public func getArea() -> String {
        return area ?? ""
    }
    public func getLong() -> Float {
        return long ?? 0.0
    }
    public func getLat() -> Float {
        return lat ?? 0.0
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
        self.id = json["id"].int
        self.name = json["name"].string
        self.type = json["type"].int
        self.desc = json["description"].string
        self.address = json["contact_address"].string
        self.area = json["geo_area"].string
        self.long = json["geo_long"].float
        self.lat = json["geo_lat"].float
        self.scheduleOpening = json["schedule_openinghour"].string
        self.scheduleClosing = json["schedule_closinghour"].string
        self.scheduleClosed = json["schedule_closed"].string
    }
}
