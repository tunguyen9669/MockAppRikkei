//
//  PopularDTO.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON

class PopularDTO {
    public var id: Int?
    public var status: Int?
    public var photo: String?
    public var name: String?
    public var descRaw: String?
    public var descHtml: String?
    public var permanent: String?
    public var dateWarning: String?
    public var timeAlert: String?
    public var startDate: String?
    public var startTime: String?
    public var endDate: String?
    public var endTime: String?
    public var oneDayEvent: String?
    public var extra: String?
    public var goingCount: Int?
    public var wentCount: Int?
    public var venueDTO: VenueDTO
    
    public func getId() -> Int {
        return id ?? 0
    }
    public func getStatus() -> Int {
        return status ?? 0
    }
    public func getPhoto() -> String {
        return self.photo ??  ""
    }
    public func getName() -> String {
        return self.name ?? ""
    }
    public func getDescRaw() -> String {
        return self.descRaw ?? ""
    }
    public func getDescHtml() -> String {
        return self.descHtml ?? ""
    }
    public func getPermanent() -> String {
        return self.permanent ?? ""
    }
    public func getDateWarning() -> String {
        return self.dateWarning ?? ""
    }
    public func getTimeAlert() -> String {
        return self.timeAlert ?? ""
    }
    public func getStartDate() -> String {
        return self.startTime ?? ""
    }
    public func getstartTime() -> String {
        return self.startTime ?? ""
    }
    public func getEndDate() -> String {
        return self.endDate ?? ""
    }
    public func getEndTime() -> String {
        return self.endTime ?? ""
    }
    public func getOneDayEvent() -> String {
        return self.oneDayEvent ?? ""
    }
    public func getExtra() -> String {
        return self.extra ?? ""
    }
    public func getGoingCount() -> Int {
        return self.goingCount ?? 0
    }
    public func getWentCount() -> Int {
        return self.wentCount ?? 0
    }
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.status = json["status"].intValue
        self.photo = json["photo"].stringValue
        self.name = json["name"].stringValue
        self.descRaw = json["description_raw"].stringValue
        self.descHtml = json["description_html"].stringValue
        self.permanent = json["schedule_permanent"].stringValue
        self.dateWarning = json["schedule_date_warning"].stringValue
        self.timeAlert = json["schedule_time_alert"].stringValue
        self.startDate = json["schedule_start_date"].stringValue
        self.startTime = json["schedule_start_time"].stringValue
        self.endDate = json["schedule_end_date"].stringValue
        self.endTime = json["schedule_end_time"].stringValue
        self.oneDayEvent = json["schedule_one_day_event"].stringValue
        self.extra = json["schedule_extra"].stringValue
        self.goingCount = json["going_count"].intValue
        self.wentCount = json["went_count"].intValue
        self.venueDTO = VenueDTO(json["venue"])
    }
}
