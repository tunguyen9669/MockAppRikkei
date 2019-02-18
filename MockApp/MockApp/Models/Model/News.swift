//
//  News.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation


class News {
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
    
    required init() {
        self.id = 0
        self.feed = "Facebook"
        self.title = "News #Thubaytruyennghe #IOS #Rikkeisoft"
        self.detailUrl = ""
        self.thumb = ""
        self.desc = ""
        self.author = "TuND"
        self.publishDate  = ""
        self.creatTime = ""
        self.updateTime = ""
    }
    
    init(_ newsDto: NewsDTO) {
        self.id = newsDto.id
        self.feed = newsDto.feed
        self.title = newsDto.title
        self.detailUrl = newsDto.detailUrl
        self.thumb = newsDto.thumb
        self.desc = newsDto.desc
        self.author = newsDto.author
        self.publishDate = newsDto.publishDate
        self.creatTime = newsDto.creatTime
        self.updateTime = newsDto.updateTime
    }
    
   
}
