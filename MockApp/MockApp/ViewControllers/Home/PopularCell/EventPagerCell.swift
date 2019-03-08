//
//  PopularPagerCell.swift
//  MockApp
//
//  Created by tund on 2/26/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class EventPagerCell: FSPagerViewCell {
    @IBOutlet weak var attendImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var inforLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // update UI
    func customInit(_ photo: String,_ title: String,_ descHtml: String, _ startDate: String, _ endDate: String, _ goingCount: Int, _ permanent: String, _ myStatus: Int) {
        if photo != "" {
            self.thumbImageView.kf.setImage(with: URL(string: photo))
        } else {
            self.thumbImageView.image = R.image.default_image()
        }
        
        
        self.inforLabel.text = "\(endDate) - \(goingCount) them gia"
        self.titleLabel.text = title
        self.descLabel.text = descHtml.htmlToString
        let token = UserPrefsHelper.shared.getUserToken()
        if token == "" || myStatus == 0 {
            attendImageView.isHidden = true
        } else {
            attendImageView.isHidden = false
            if myStatus == 1 {
                attendImageView.image = R.image.red_star()
            } else {
                attendImageView.image = R.image.yellow_star()
            }
        }
        
    }

}
