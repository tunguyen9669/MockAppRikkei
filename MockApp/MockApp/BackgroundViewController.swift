//
//  BackgroundViewController.swift
//  MockApp
//
//  Created by tund on 3/13/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class BackgroundViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToHome), userInfo: nil, repeats: false)
    }
    
    @objc func moveToHome() {
        appDelegate.moveToHome()
    }
}
