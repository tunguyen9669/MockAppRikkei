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
}

