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
    @IBAction func onForgot(_ sender: Any) {
        if let forgotVC = R.storyboard.myPage.forgotPasswordViewController() {
            self.navigationController?.pushViewController(forgotVC, animated: true)
        }
    }
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
