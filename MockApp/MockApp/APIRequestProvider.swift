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
    private var requestURL: String = "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/"
    
    private var _headers: HTTPHeaders = [:]
    var headers: HTTPHeaders {
        set {
            _headers = headers
        }
        get {
            let authorizationCode = UserPrefsHelper.shared.getUserToken()
            let headers: HTTPHeaders = [
                "Authorization": authorizationCode
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
        let urlRequest = requestURL.appending("listPopularEvents?")
        let params = ["pageIndex": "\(pageIndex)",
            "pageSize": "\(10)"]
        
        return alamoFireManager.request(urlRequest,
                                        method: .get,
                                        parameters: params,
                                        encoding: URLEncoding.default,
                                        headers: headers)
        
    }
}
