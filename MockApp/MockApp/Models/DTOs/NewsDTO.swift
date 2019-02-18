//
//  NewsDTO.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsDTO {
    public var id: Int?
    public var feed: String?
    public var title: String?
    public var detailUrl: String?
    public var thumb: String?
    public var description: String?
    public var author: String?
    public var publishDate: String?
    public var creatTime: String?
    public var updateTime: String?
    
    public func getId() -> Int {
        return id ?? 0
    }
    public func getFeed() -> String {
        return feed ?? ""
    }
    public func getTitle() -> String {
        return title ?? ""
    }
    public func getDetailUrl() -> String {
        return detailUrl ?? ""
    }
    public func getThumb() -> String {
        return thumb ?? ""
    }
    public func getDescription() -> String {
        return description ?? ""
    }
    public func getAuthor() -> String {
        return author ?? ""
    }
    public func getPublishDate() -> String {
        return publishDate ?? ""
    }
    public func getCreatTime() -> String {
        return creatTime ?? ""
    }
    public func getUpdateTime() -> String {
        return updateTime ?? ""
    }
    
    init(_ json: JSON) {
        self.id = json["id"].intValue
        self.feed = json["feed"].stringValue
        self.title = json["title"].stringValue
        self.detailUrl = json["detail_url"].stringValue
        self.thumb = json["thumb_img"].stringValue
        self.description = json["description"].stringValue
        self.author = json["author"].stringValue
        self.publishDate = json["publish_date"].stringValue
        self.creatTime = json["created_at"].stringValue
        self.updateTime = json["updated_at"].stringValue
    }
}
