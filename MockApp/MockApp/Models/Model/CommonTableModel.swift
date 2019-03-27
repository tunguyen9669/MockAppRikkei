//
//  CommonTableModel.swift
//  MockApp
//
//  Created by tund on 2/25/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class CommonTableModel {
    // HaND: Không cần public ở đây. Public chỉ dùng khi cần chạy ở module khác.
    public var title: String?
    public var arrEvents: [Event]?
    // HaND: Không cần thêm hàm get nữa, dùng luôn hàm get mặc định
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
            // HaND: Thêm 1 biến nữa get only = "\(po1.getEndDate()) \(po1.getEndTime())".convertStringToMilisecond()
            return "\(po1.getEndDate()) \(po1.getEndTime())".convertStringToMilisecond() >= "\(po2.getEndDate()) \(po2.getEndTime())".convertStringToMilisecond()
        }
    }
    
}
