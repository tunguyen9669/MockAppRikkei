//
//  Popular.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class Popular {
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
    public var venue: Venue
    
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
    public func getStartTime() -> String {
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
    
    init() {
        self.id = 0
        self.status = 0
        self.photo = ""
        self.name = ""
        self.descRaw = ""
        self.descHtml = ""
        self.permanent = ""
        self.dateWarning = ""
        self.timeAlert = ""
        self.startDate = ""
        self.startTime = ""
        self.endDate = ""
        self.endTime = ""
        self.oneDayEvent = ""
        self.extra = ""
        self.goingCount = 0
        self.wentCount = 0
        self.venue = Venue()
    }
    
    init(_ popularDto: PopularDTO) {
        self.id = popularDto.getId()
        self.status = popularDto.getStatus()
        self.photo = popularDto.getPhoto()
        self.name = popularDto.getName()
        self.descRaw = popularDto.getDescRaw()
        self.descHtml = popularDto.getDescHtml()
        self.permanent = popularDto.getPermanent()
        self.dateWarning = popularDto.getDateWarning()
        self.timeAlert = popularDto.getTimeAlert()
        self.startDate = popularDto.getStartDate()
        self.startTime = popularDto.getstartTime()
        self.endDate = popularDto.getEndDate()
        self.endTime = popularDto.getEndTime()
        self.oneDayEvent = popularDto.getOneDayEvent()
        self.extra = popularDto.getExtra()
        self.goingCount = popularDto.getGoingCount()
        self.wentCount = popularDto.getWentCount()
        self.venue = Venue(popularDto.venueDTO)
    }
}
