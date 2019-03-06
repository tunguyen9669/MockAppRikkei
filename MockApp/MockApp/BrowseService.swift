//
//  BrowseService.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//


import Foundation
import SwiftyJSON
import Alamofire
class BrowseService: APIServiceObject {
    func requestGetListCategory(_ pageIndex: Int, completion: @escaping (Result<[CategoryDTO]>) -> Void) {
        var categories = [CategoryDTO]()
        let request =  APIRequestProvider.shareInstance.getCategories(pageIndex)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                let data = json["response"]["categories"].arrayValue
                
                for item in data {
                    categories.append(CategoryDTO(item))
                }
                completion(Result.success(categories))
            }
        }
    }
    
    func requestGetListEventsByCT(_ pageIndex: Int, _ id: Int, completion: @escaping (Result<[EventDTO]>) -> Void) {
        var events = [EventDTO]()
        let request = APIRequestProvider.shareInstance.getEventsByCategory(pageIndex, id)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                let data = json["response"]["events"].arrayValue
                
                for item in data {
                    events.append(EventDTO(item))
                }
                completion(Result.success(events))
            }
        }
    }
    
    func requestSearch(_ pageIndex: Int, _ keyword: String,_ completion: @escaping (Result<[EventDTO]>) -> Void) {
        var events = [EventDTO]()
        let request = APIRequestProvider.shareInstance.search(pageIndex, keyword)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                let data = json["response"]["events"].arrayValue
                
                for item in data {
                    events.append(EventDTO(item))
                }
                completion(Result.success(events))
            }
        }
        
    }
}

