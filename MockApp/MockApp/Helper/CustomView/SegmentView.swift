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
    var title: String?
    func setSelected(_ isSelected: Bool) {
        self.selectedView.isHidden = !isSelected
        
        if isSelected {
            self.title = titleLabel.text ?? ""
            titleLabel.textColor = UIColor.tabbarColor
            titleLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        }else{
            titleLabel.textColor = UIColor.pumpkinOrange
            titleLabel.font = UIFont(name: "Roboto-Regular", size: 17)
        }
        animateView()
    }
    
    func animateView() {
        selectedView.alpha = 0;
        if self.title == "Popular" {
            self.selectedView.frame.origin.x = self.selectedView.frame.origin.x - 50
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.selectedView.alpha = 1.0;
                self.selectedView.frame.origin.x = self.selectedView.frame.origin.x + 50
            })
        } else {
            self.selectedView.frame.origin.x = self.selectedView.frame.origin.x + 50
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.selectedView.alpha = 1.0;
                self.selectedView.frame.origin.x = self.selectedView.frame.origin.x - 50
            })
        }
        
    }
}
