//
//  SortTitleView.swift
//  MockApp
//
//  Created by tund on 3/4/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class SortTitleView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        }else{
            titleLabel.textColor = UIColor.black
            titleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        }
    }
}
