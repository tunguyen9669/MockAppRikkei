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
    public var desc: String?
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
        return desc ?? ""
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
        self.id = json["id"].int
        self.feed = json["feed"].string
        self.title = json["title"].string
        self.detailUrl = json["detail_url"].string
        self.thumb = json["thumb_img"].string
        self.desc = json["description"].string
        self.author = json["author"].string
        self.publishDate = json["publish_date"].string
        self.creatTime = json["created_at"].string
        self.updateTime = json["updated_at"].string
    }
}
