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
    public var arrPopulars: [Popular]?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    public func getPopulars() -> [Popular] {
        return arrPopulars ?? []
    }
    
    init(_ title: String, _ arrPopulars: [Popular]) {
        self.title = title
        self.arrPopulars = arrPopulars
    }
    
}
