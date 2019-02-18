//
//  StringExtension.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
extension String {
    func convertStringToMilisecond() -> Int {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        if let date = formater.date(from: self) {
            return Int(date.timeIntervalSince1970)
        } else {
            return -1
        }
        
    }
}
