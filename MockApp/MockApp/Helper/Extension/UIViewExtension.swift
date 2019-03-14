//
//  UIViewExtension.swift
//  MockApp
//
//  Created by tund on 3/14/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
