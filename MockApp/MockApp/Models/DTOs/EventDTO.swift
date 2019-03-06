//
//  PopularDTO.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON

class EventDTO {
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
    public var distance: Float?
    public var myStatus: Int?
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
    public func getMyStatus() -> Int {
        return self.myStatus ?? 0
    }
    public func getGoingCount() -> Int {
        return self.goingCount ?? 0
    }
    public func getWentCount() -> Int {
        return self.wentCount ?? 0
    }
    public func getDistance() -> Float{
        return self.distance ?? 0.0
    }
    
    init(_ json: JSON) {
        self.id = json["id"].int
        self.status = json["status"].int
        self.photo = json["photo"].string
        self.name = json["name"].string
        self.descRaw = json["description_raw"].string
        self.descHtml = json["description_html"].string
        self.permanent = json["schedule_permanent"].string
        self.dateWarning = json["schedule_date_warning"].string
        self.timeAlert = json["schedule_time_alert"].string
        self.startDate = json["schedule_start_date"].string
        self.startTime = json["schedule_start_time"].string
        self.endDate = json["schedule_end_date"].string
        self.endTime = json["schedule_end_time"].string
        self.oneDayEvent = json["schedule_one_day_event"].string
        self.extra = json["schedule_extra"].string
        self.distance = json["distance"].float
        self.myStatus = json["my_status"].int
        self.goingCount = json["going_count"].int
        self.wentCount = json["went_count"].int
        self.venueDTO = VenueDTO(json["venue"])
    }
}
