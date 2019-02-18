//
//  APIServiceAgent.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CFNetwork

class APIServiceAgent: NSObject {
    func startRequest(_ request: DataRequest, completion: @escaping (JSON, NSError?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        request
            .responseJSON { (response: DataResponse<Any>) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(json, nil)
                case .failure(let error as NSError):
                    completion(JSON.null, error)
                }
        }
    }
}
