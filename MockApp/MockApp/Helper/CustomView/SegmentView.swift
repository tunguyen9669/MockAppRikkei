//
//  SegmentView.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class SegmentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    func setSelected(_ isSelected: Bool) {
        self.selectedView.isHidden = !isSelected
        if isSelected {
            titleLabel.textColor = UIColor.tabbarColor
            titleLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        }else{
            titleLabel.textColor = UIColor.pumpkinOrange
            titleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        }
    }
}
