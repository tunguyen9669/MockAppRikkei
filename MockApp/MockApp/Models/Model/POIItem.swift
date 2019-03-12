//
//  POIItem.swift
//  MockApp
//
//  Created by tund on 3/12/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    var icon: UIImage!
    
    init(position: CLLocationCoordinate2D, name: String, icon: UIImage) {
        self.position = position
        self.name = name
        self.icon = icon
    }
}
