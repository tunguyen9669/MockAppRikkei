//
//  IntExtension.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

extension Int {
    func isToday() -> Bool {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        if calendar.isDateInToday(date) {
            return true
        } else {
            return false
        }
    }
    
    func dayDifference() -> String {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
}
