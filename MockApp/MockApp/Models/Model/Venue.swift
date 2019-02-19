//
//  Venue.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class Venue {
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
    
    init() {
        self.id = 0
        self.name = ""
        self.type = 0
        self.desc = ""
        self.scheduleOpening = ""
        self.scheduleClosing = ""
        self.scheduleClosed = ""
    }
    init(_ venueDto: VenueDTO) {
        self.id = venueDto.getId()
        self.name = venueDto.getName()
        self.type = venueDto.getType()
        self.desc = venueDto.getDesc()
        self.scheduleClosing = venueDto.getClosing()
        self.scheduleOpening = venueDto.getOpening()
        self.scheduleClosed = venueDto.getClosed()
    }
    
}
