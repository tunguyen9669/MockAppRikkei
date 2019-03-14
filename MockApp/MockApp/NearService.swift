//
//  NearService.swift
//  MockApp
//
//  Created by tund on 3/6/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class NearService: APIServiceObject {
    func requestListNearlyEvents(_ radius: Float, _ longitude: Float,_ latitude: Float,_ completion: @escaping (Result<[EventDTO]>) -> Void ) {
        var events = [EventDTO]()
        let requet = APIRequestProvider.shareInstance.listNearlyEvent(radius, longitude, latitude)
        serviceAgent.startRequest(requet) { (json, error) in
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
