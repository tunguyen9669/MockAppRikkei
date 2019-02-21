//
//  UITextFieldExtension.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setIsOnFocus(_ isOnFocus: Bool) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = isOnFocus ? UIColor.pumpkinOrange.cgColor : UIColor.disableColor.cgColor
        
        let frameWidth = self.frame.size.width
        let frameHeight = self.frame.size.height
        border.frame = CGRect(x: 0,
                              y: frame.size.height - width,
                              width: frameWidth,
                              height: frameHeight)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
}
