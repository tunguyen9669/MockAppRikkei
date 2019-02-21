//
//  MyPageService.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class MyPageService: APIServiceObject {

    func requestRegister(_ fullname: String, _ email: String, _ password: String, completion: @escaping (String) -> Void) {
        let request = APIRequestProvider.shareInstance.register(fullname, email, password)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                //                    let msg = json["errors"]["first_error"].stringValue
                let msg = "Data fail: " + error.localizedDescription
                completion(msg)
            } else {
                if json["status"].intValue == 1 {
                    let data = json["response"]["token"].stringValue
                    completion(data)
                } else {
                    let msg = "Tài khoản đã được đăng kí từ trước, vui lòng nhập email khác"
                    completion(msg)
                }
            }
        }
    }
    
    func requestLogin(_ email: String, _ password: String, _ completion: @escaping(String) -> Void) {
        let request = APIRequestProvider.shareInstance.login(email, password)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                //                    let msg = json["errors"]["first_error"].stringValue
                let msg = "Data fail: " + error.localizedDescription
                completion(msg)
            } else {
                if json["status"].intValue == 1 {
                    let data = json["response"]["token"].stringValue
                    completion(data)
                } else {
                    let msg = "Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại"
                    completion(msg)
                }
            }
        }
    }
    
    func requestResetPass(_ email: String, _ completion: @escaping(String) -> Void) {
        let request = APIRequestProvider.shareInstance.resetPass(email)
        serviceAgent.startRequest(request) { (json, error) in
            if let error = error {
                let msg = "Data fail: " + error.localizedDescription
                completion(msg)
            } else {
                if json["status"].intValue == 1 {
                    let msg = "Đổi mật khẩu thành công"
                    completion(msg)
                } else {
                    let msg = "Đổi mật khẩu thất bại"
                    completion(msg)
                }
            }
        }
    }
}
