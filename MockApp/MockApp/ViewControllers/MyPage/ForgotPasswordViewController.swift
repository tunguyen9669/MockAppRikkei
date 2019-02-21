//
//  ForgotPasswordViewController.swift
//  MockApp
//
//  Created by tund on 2/20/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    // MARK: - outlet, actions and variable
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    let services = MyPageService()
    
    @IBAction func onReset(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        if email.isValidEmail() == false {
            print(email)
            if email.isValidEmail() == false {
                self.alertWith("Định dạng email không đúng")
            }
        } else {
            self.resetPass(email)
        }
        
    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        resetButton.backgroundColor = UIColor.disableColor
        resetButton.layer.cornerRadius = 4
        
        //tap screen
        let onTapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(onTapViewGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.tabbar?.setHidden(false)
    }
    
    // MARK: - function
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func resetPass(_ email: String) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestResetPass(email) { (message) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.alertWith(message)
            }
        } else {
             self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
}
// MARK: - extension

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text != "" {
            resetButton.isEnabled = true
            resetButton.backgroundColor = UIColor.tabbarColor
        } else {
            resetButton.isEnabled = false
            resetButton.backgroundColor = UIColor.disableColor
        }
    }
}
