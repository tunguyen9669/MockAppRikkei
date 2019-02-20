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
    @IBAction func onLogin(_ sender: Any) {
        if let loginVC = R.storyboard.myPage.loginViewController() {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
