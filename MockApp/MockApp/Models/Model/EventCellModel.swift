//
//  EventCellModel.swift
//  MockApp
//
//  Created by tund on 2/25/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class EDModel {
    public var identifier: String?
    
    public func getIdentifier() -> String {
        return self.identifier ?? ""
    }
    
    init(_ identifier: String) {
        self.identifier = identifier
    }
}
