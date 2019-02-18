//
//  NewsCell.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inforNewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func customInit(_ thumbImg: String, _ title: String, _ publishDate: String,_ author: String, _ feed: String){
        let milisecond = publishDate.convertStringToMilisecond()
        
        self.thumbImageView.kf.setImage(with: URL(string: thumbImg))
        self.titleLabel.text = title
        self.inforNewsLabel.text = "\(milisecond.dayDifference()) by \(author) \(feed)"
    }
    
}
