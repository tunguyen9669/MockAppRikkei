//
//  APIRequestProvider.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import Alamofire

class APIRequestProvider: NSObject {
    // MARK: - variable
    private var requestURL: String = "http://172.16.18.81/18175d1_mobile_100_fresher/public/api/v0/"
    
    private var _headers: HTTPHeaders = [:]
    var headers: HTTPHeaders {
        set {
            _headers = headers
        }
        get {
            let authorizationCode = UserPrefsHelper.shared.getUserToken()
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(authorizationCode)"
            ]
            return headers
        }
    }
    
    // MARK: - SINGLETON
    static var shareInstance: APIRequestProvider = {
        let instance = APIRequestProvider()
        return instance
    }()
    var alamoFireManager: SessionManager
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 120
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    // MARK: - Authorization Requests
    
    func login(_ email: String, _ password: String) -> DataRequest {
        let urlRequest = requestURL.appending("login")
        let params = ["email": email,
                      "password": password]
        return alamoFireManager.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: nil)
    }
    
    func register(_ fullname: String, _ email: String, _ password: String) -> DataRequest {
        let urlRequest = requestURL.appending("register")
        let params = ["name": fullname,
                      "email": email,
                      "password": password]
        return alamoFireManager.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: nil)
    }
    
    func resetPass(_ email: String) -> DataRequest {
        let urlRequest = requestURL.appending("resetPassword")
        let params = ["email": email]
        
        return alamoFireManager.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: nil)
    }

    // MARK: - home request
    func getNewsList(_ pageIndex: Int) -> DataRequest {
        let urlRequest = requestURL.appending("listNews")
        let params = ["pageIndex": "\(pageIndex)",
            "pageSize": "\(10)"]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: nil)
    }
    
    func getPopularEvents(_ pageIndex: Int) -> DataRequest {
        let urlRequest = requestURL.appending("listPopularEvents")
        let params = ["pageIndex": "\(pageIndex)",
            "pageSize": "\(10)"]
        
        print("Header: \(self.headers)")
        
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: self.headers)
        
    }
    
    func getMyEvents(_ status: Int) -> DataRequest{
        let urlRequest = requestURL.appending("listMyEvents")
        let params = ["status": status]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func getDetailEvent(_ id: Int) -> DataRequest {
        let urlRequest = requestURL.appending("getDetailEvent")
        let params = ["event_id": id]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func followVenue(_ id: Int) -> DataRequest {
        let urlRequest = requestURL.appending("doFollowVenue")
        let params = ["venue_id": id]
        return alamoFireManager.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func updateEvent(_ status: Int, _ id: Int) -> DataRequest {
        let urlRequest = requestURL.appending("doUpdateEvent")
        let params = ["status": status,
                      "event_id": id]
        return alamoFireManager.request(urlRequest,
                                        method: .post,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func getCategories(_ pageIndex: Int) -> DataRequest {
        let urlRequest = requestURL.appending("listCategories")
        let params = ["pageIndex": pageIndex,
                      "pageSize": 15]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func getEventsByCategory(_ pageIndex: Int, _ id: Int) -> DataRequest {
        let urlRequest = requestURL.appending("listEventsByCategory")
        let params = ["pageIndex": pageIndex,
                      "pageSize": 10,
                      "category_id": id]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    
    func search(_ pageIndex: Int,_ keyword: String) -> DataRequest {
        let urlRequest = requestURL.appending("search")
        let params = ["pageIndex": pageIndex,
                      "pageSize": 10,
                      "keyword": keyword] as [String : Any]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
    func listNearlyEvent(_ radius: Float,_ longitude: Float, _ latitude: Float) -> DataRequest {
        let urlRequest = requestURL.appending("listNearlyEvents")
        let params = ["radius": radius,
                      "longitue": longitude,
                      "latitude": latitude]
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
    }
}
