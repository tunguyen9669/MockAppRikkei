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
        print("Click")
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passTextField.delegate = self
        
        //tap screen
        let onTapViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(onTapViewGestureRecognizer)
    }
    
    // MARK: - function
    @objc func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
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
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if fullnameTextField.text != "" && emailTextField.text != "" && passTextField.text != "" {
            signUpButton.isEnabled = true
        } else {
            signUpButton.isEnabled = false
        }
    }
}
