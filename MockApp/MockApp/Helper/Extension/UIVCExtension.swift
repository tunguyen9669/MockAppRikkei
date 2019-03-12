//
//  UIVCExtension.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertWith(_ message: String?) {
        let alertController = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func getDateNow() -> Int {
        let date = NSDate()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let min = calendar.component(.minute, from: date as Date)
        let second = calendar.component(.second, from: date as Date)
        let timeNow = "\(year)-\(month)-\(day) \(hour):\(min):\(second)"
        return timeNow.convertStringToMilisecond()
    }
    
    func getTimeEndEvent(_ time: Int) -> Int {
        /*
         1: Today
         2: Tomorrow
         3: This week
         4: Next week
         5: This month
         6: Next month
         7: Later
         8: End
            */
        
        let date = NSDate()
        let calendar = Calendar.current
        let monthNow = calendar.component(.month, from: date as Date)
        let yearNow = calendar.component(.year, from: date as Date)
        let dayNow = calendar.component(.day, from: date as Date)
        let weekNow = calendar.component(.weekOfMonth, from: date as Date)
        
        let endDate = Date(timeIntervalSince1970: TimeInterval(time))
        let monthEnd = calendar.component(.month, from: endDate as Date)
        let yearEnd = calendar.component(.year, from: endDate as Date)
        let dayEnd = calendar.component(.day, from: endDate as Date)
        let weekEnd = calendar.component(.weekOfMonth, from: endDate as Date)
        
        // compare date component
        if yearEnd < yearNow {
            return 8
        } else if yearEnd == yearNow {
            if monthEnd < monthNow {
                return 8
            } else if monthEnd > monthNow {
                if monthEnd - monthNow > 1 {
                    return 7
                } else {
                    if weekEnd - weekNow == 1 {
                        return 4
                    }
                    if weekEnd == weekNow {
                        if dayEnd == dayNow {
                            return 1
                        }
                        if dayEnd - dayNow == 1 {
                            return 2
                        }
                        return 3
                    }
                    return 6
                }
            }
        }
        return 7
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func sortInArrray(_ arr: [Event]) -> [Event] {
        var events = arr
        events = events.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        return events
        
    }
}
