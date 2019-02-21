//
//  WentViewController.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class WentViewController: UIViewController {
    
    var countTap = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Went tap: \(countTap)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countTap = 1
    }
}
