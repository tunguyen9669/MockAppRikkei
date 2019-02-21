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
    // MARK: - home request
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
    
    // MARK: - authentication request
    
    func requestRegister(_ fullname: String, _ email: String, _ password: String, completion: @escaping (Result<String>) -> Void) {
        let request = APIRequestProvider.shareInstance.register(fullname, email, password)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                completion(Result.failure(error))
            } else {
                print("Register JSON: \(json)")
                if json["status"].intValue == 1 {
                    let data = json["response"]["token"].stringValue
                    completion(Result.success(data))
                } else {
                    let msg = "Tài khoản đã được đăng kí từ trước, vui lòng nhập email khác"
                    completion(Result.success(msg))
                }
            }
        }
    }
}

