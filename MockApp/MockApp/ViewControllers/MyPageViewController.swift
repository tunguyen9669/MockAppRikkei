//
//  MyPageViewController.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var registerContainer: UIView!
    @IBOutlet weak var myListContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check Loggined
        let checkLogin = UserPrefsHelper.shared.getIsLoggined()
        if checkLogin == true {
            registerContainer.isHidden = true
            myListContainer.isHidden = false
        } else {
            registerContainer.isHidden = false
            myListContainer.isHidden = true
        }
    }
}
