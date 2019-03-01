//
//  CategoryRealmModel.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import RealmSwift

public class CategoryRealmModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var slug: String = ""
    @objc dynamic var parentId: Int = 0
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}
