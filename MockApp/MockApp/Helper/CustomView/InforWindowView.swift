//
//  InforWindowView.swift
//  MockApp
//
//  Created by tund on 3/14/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import Kingfisher

class InforWindowView: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 6
        self.bgView.layer.borderWidth = 3
        
        self.bgView.layer.borderColor = UIColor.blueColor.cgColor
    }
    
    func customInit(_ photo: String,_ name: String,_ distance: Float) {
        if photo != "" {
            self.photoImageView.kf.setImage(with: URL(string: photo))
        } else {
            self.photoImageView.image = R.image.default_image()
        }
      
        self.nameLabel.text = name
        let distanceValue = String(format: "%\(0.2)f", distance)
        self.distanceLabel.text = "\(distanceValue) m"
        
        
    }

}
