//
//  Category.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class Category {
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
    
    public func getSlug() -> String {
        return slug ?? ""
    }
    
    public func getParentId() -> Int {
        return parentId ?? 0
    }
    
    init() {
        self.id = 0
        self.name = ""
        self.slug = ""
        self.parentId = 0
    }
    
    init(_ categoryDTO: CategoryDTO) {
        self.id = categoryDTO.getId()
        self.name = categoryDTO.getName()
        self.slug = categoryDTO.getSlug()
        self.parentId = categoryDTO.getParentId()
    }
}
