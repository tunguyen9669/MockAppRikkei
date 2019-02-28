//
//  CommonTableModel.swift
//  MockApp
//
//  Created by tund on 2/25/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class CommonTableModel {
    public var title: String?
    public var arrEvents: [Event]?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    public func getEvents() -> [Event] {
        return arrEvents ?? []
    }
    
    init(_ title: String, _ arrEvents: [Event]) {
        self.title = title
        self.arrEvents = arrEvents
        self.arrEvents = getEvents().sorted { (po1, po2) -> Bool in
            return "\(po1.getEndDate()) \(po1.getEndTime())".convertStringToMilisecond() >= "\(po2.getEndDate()) \(po2.getEndTime())".convertStringToMilisecond()
        }
    }
    
}
