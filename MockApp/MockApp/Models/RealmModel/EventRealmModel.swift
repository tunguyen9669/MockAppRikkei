//
//  PopularRealmModel.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

public class EventRealmModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var status: Int = 0
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
    @objc dynamic var myStatus: Int = 0
    @objc dynamic var goingCount: String = ""
    @objc dynamic var wentCount: String = ""
    @objc dynamic var venue: VenueRealmModel?
    
    func getVenue() -> VenueRealmModel {
        return venue ?? VenueRealmModel()
    }
 
    override public static func primaryKey() -> String? {
        return "id"
    }
    convenience  init(_ event: Event) {
        //
        self.init()
        self.id = event.getId()
        self.status = event.getStatus()
        self.photo = event.getPhoto()
        self.name = event.getName()
        self.descRaw = event.getDescRaw()
        self.descHtml = event.getDescHtml()
        self.permanent = event.getPermanent()
        self.dateWarning = event.getDateWarning()
        self.timeAlert = event.getTimeAlert()
        self.startDate = event.getStartDate()
        self.startTime = event.getStartTime()
        self.endDate = event.getEndDate()
        self.endTime = event.getEndTime()
        self.oneDayEvent = event.getOneDayEvent()
        self.extra = event.getExtra()
        self.myStatus = event.getMyStatus()
        self.goingCount = event.getGoingCount().description
        self.wentCount = event.getWentCount().description
        self.getVenue().id = event.venue.getId()
        self.getVenue().name = event.venue.getName()
        self.getVenue().type = event.venue.getType()
        self.getVenue().desc = event.venue.getDesc()
        self.getVenue().area = event.venue.getArea()
        self.getVenue().address = event.venue.getAdress()
        self.getVenue().lat = event.venue.getLat()
        self.getVenue().long = event.venue.getLong()
        self.getVenue().scheduleOpening = event.venue.getOpening()
        self.getVenue().scheduleClosing = event.venue.getClosing()
        self.getVenue().scheduleClosed = event.venue.getClosed()
        
    }
}

