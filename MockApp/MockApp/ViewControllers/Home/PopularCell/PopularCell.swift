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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customInit(_ photo: String,_ name: String,_ descHtml: String, _ startDate: String, _ endDate: String, _ goingCount: Int, _ permanent: String) {
        if photo != "" {
            self.thumbImageView.kf.setImage(with: URL(string: photo))
        }
        
        self.nameLabel.text = name
        self.descHtmlLabel.text = descHtml
        let token = UserPrefsHelper.shared.getUserToken()
        if token == "" {
            attendImageView.isHidden = true
        } else {
            attendImageView.isHidden = false
        }
        
    }
}
