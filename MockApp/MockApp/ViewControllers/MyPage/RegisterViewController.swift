//
//  RegisterViewController.swift
//  MockApp
//
//  Created by tund on 2/20/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    // MARK: - outlet, actions and variable
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func onLogin(_ sender: Any) {
        if let loginVC = R.storyboard.myPage.loginViewController() {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        guard let name = fullnameTextField.text,
            let email = emailTextField.text,
            let pass = passTextField.text else {
                return
        }
        print("\(name) \(email) \(pass)")
    
        if email.isValidEmail() == false {
            self.alertWith("Định dạng email không đúng")
        } else if pass.count < 6 || pass.count > 16 {
            self.alertWith("Độ dài mật khẩu phải từ 6 - 16 kí tự")
        } else {
            self.register(name, email, pass) { (result) in
                if result == true {
                    if let myListEventVC = R.storyboard.myPage.myListEventViewController() {
                        self.navigationController?.pushViewController(myListEventVC, animated: true)
                    }
                }
            }
            
        }
        
    }
    
    let services = MyPageService()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.backgroundColor = UIColor.disableColor
        signUpButton.layer.cornerRadius = 4
        
        fullnameTextField.delegate = self
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
        fullnameTextField.setIsOnFocus(true)
        emailTextField.setIsOnFocus(true)
        passTextField.setIsOnFocus(true)
    }
    
    
    // MARK: - function
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func register(_ fullname: String, _ email: String, _ password: String, _ completion: @escaping (Bool) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestRegister(fullname, email, password) { (message) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if message.isEqual("Tài khoản đã được đăng kí từ trước, vui lòng nhập email khác") {
                    completion(false)
                    self.alertWith(message)
                } else {
                    completion(true)
                    self.alertWith("Đăng kí thành công")
                    UserPrefsHelper.shared.setUserToken(message)
                    UserPrefsHelper.shared.setIsloggined(true)
                }
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }

}


// MARK: - extension
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == fullnameTextField {
            emailTextField.becomeFirstResponder()
        } else {
            emailTextField.resignFirstResponder()
        }
        if textField == emailTextField {
            passTextField.becomeFirstResponder()
        } else {
            passTextField.resignFirstResponder()
        }
        return true
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.setIsOnFocus(false)
//        return true
//    }
//
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        textField.setIsOnFocus(false)
        if fullnameTextField.text != "" && emailTextField.text != "" && passTextField.text != "" {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.tabbarColor
        } else {
            signUpButton.backgroundColor = UIColor.disableColor
            signUpButton.isEnabled = false
        }
    }
}

