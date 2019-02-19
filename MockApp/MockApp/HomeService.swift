//
//  HomeService.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class HomeService: APIServiceObject {
    func requestGetNewsList(_ pageIndex: Int, completion: @escaping (Result<[NewsDTO]>) -> Void) {
        var listNews = [NewsDTO]()
        let request =  APIRequestProvider.shareInstance.getNewsList(pageIndex)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
//                print("Json: \(json)")
                
                let data = json["response"]["news"].arrayValue
//                print("Data: \(data)")
                // cho nay a oi
                for item in data {
                    listNews.append(NewsDTO(item))
                }
                completion(Result.success(listNews))
            }
        }
    }
    
    func requestGetPopularEvents(_ pageIndex :Int, completion: @escaping (Result<[PopularDTO]>) -> Void) {
        var listPopular = [PopularDTO]()
        let request = APIRequestProvider.shareInstance.getPopularEvents(pageIndex)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                print("Popular JSON: \(json)")
                let data = json["response"]["events"].arrayValue
                for item in data {
                    listPopular.append(PopularDTO(item))
                }
                completion(Result.success(listPopular))
            }
        }
    }
}

