//
//  LoginViewController.swift
//  MockApp
//
//  Created by tund on 2/20/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    // MARK: - oulet, actions and variable
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func onLogin(_ sender: Any) {
        guard let email = emailTextField.text,
            let pass = passTextField.text else {
                return
        }
        print("\(email) \(pass)")
        
        if email.isValidEmail() == false {
            self.alertWith("Định dạng email không đúng")
        } else if pass.count < 6 || pass.count > 16 {
            self.alertWith("Độ dài mật khẩu phải từ 6 - 16 kí tự")
        } else {
            self.login(email, pass) { (result) in
                if result == true {
                    NotificationCenter.default.post(name: Notification.Name.kLogin, object: nil, userInfo: ["type": "login"])
                    if let myListEventVC = R.storyboard.myPage.myListEventViewController() {
                        self.navigationController?.pushViewController(myListEventVC, animated: true)
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func onForgot(_ sender: Any) {
        if let forgotVC = R.storyboard.myPage.forgotPasswordViewController() {
            self.navigationController?.pushViewController(forgotVC, animated: true)
        }
    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    let services = MyPageService()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 4
        loginButton.backgroundColor = UIColor.disableColor
        emailTextField.delegate = self
        passTextField.delegate = self
        //tap screen
        let onTapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(onTapViewGestureRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.tabbar?.setHidden(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - function
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func login(_ email: String,  _ password: String, _ completion: @escaping (Bool) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestLogin(email, password) { (message) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if message.isEqual("Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại") {
                    completion(false)
                    self.alertWith(message)
                } else {
                    completion(true)
                    self.alertWith("Đăng nhập thành công")
                    UserPrefsHelper.shared.setUserToken(message)
                    UserPrefsHelper.shared.setIsloggined(true)
                    print("User token token: \(UserPrefsHelper.shared.getUserToken())")
                    
                }
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
}

// MARK
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passTextField.becomeFirstResponder()
        } else {
            passTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        textField.setIsOnFocus(false)
        if emailTextField.text != "" && passTextField.text != "" {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.tabbarColor
        } else {
            loginButton.backgroundColor = UIColor.disableColor
            loginButton.isEnabled = false
        }
    }
    
}
