//
//  CategoryDTO.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoryDTO {
    public var id: Int?
    public var name: String?
    public var slug: String?
    public var parentId: Int?
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    public func getParentId() -> Int {
        return parentId ?? 0
    }
    
    public func getSlug() -> String {
        return slug ?? ""
    }
    
    init(_ json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.slug = json["slug"].string
        self.parentId = json["parent_id"].int
    }
}
