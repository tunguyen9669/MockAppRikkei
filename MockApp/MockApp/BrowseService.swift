//
//  BrowseService.swift
//  MockApp
//
//  Created by tund on 3/1/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
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
}

