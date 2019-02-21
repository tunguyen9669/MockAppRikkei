//
//  GoingViewController.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class GoingViewController: UIViewController {
    
    var countTap = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Going tap: \(countTap)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countTap = 1
    }
}
