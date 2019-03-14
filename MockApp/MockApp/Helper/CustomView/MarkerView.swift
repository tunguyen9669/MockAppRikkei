//
//  MarkerView.swift
//  MockApp
//
//  Created by tund on 3/14/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit

class MarkerView: UIView {
    
    var name: String?
    var photo: String?
    var distance: Float?
    
    init(frame: CGRect, name: String, photo: String, distance: Float) {
        super.init(frame: frame)
        self.name = name
        self.photo = photo
        self.distance = distance
        self.loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
   
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib  = UINib(nibName: "MarkerView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
    

}
