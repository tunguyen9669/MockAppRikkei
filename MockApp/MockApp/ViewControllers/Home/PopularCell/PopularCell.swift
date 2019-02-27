//
//  PopularCell.swift
//  MockApp
//
//  Created by tund on 2/19/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import Kingfisher

class PopularCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descHtmlLabel: UILabel!
    @IBOutlet weak var inforLabel: UILabel!
    @IBOutlet weak var attendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // update UI
    func customInit(_ photo: String,_ name: String,_ descHtml: String, _ startDate: String, _ endDate: String, _ goingCount: Int, _ permanent: String, _ myStatus: Int) {
        if photo != "" {
            self.thumbImageView.kf.setImage(with: URL(string: photo))
        } else {
            self.thumbImageView.image = R.image.default_image()
        }
        
        
         self.inforLabel.text = "\(endDate) - \(goingCount) them gia"
        self.nameLabel.text = name
        self.descHtmlLabel.text = descHtml.htmlToString
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
