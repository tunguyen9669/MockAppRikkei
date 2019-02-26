//
//  FirstEDCell.swift
//  MockApp
//
//  Created by tund on 2/25/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import Kingfisher

protocol FirstEDCellDelegate: class {
    func onClose()
   
}

class FirstEDCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var inforLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    weak var delegate: FirstEDCellDelegate?
    @IBAction func onClose(_ sender: Any) {
        delegate?.onClose()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func customInit(_ name: String, _ photo: String,_ detail: String,_ date: String,_ goingCount: Int,_ location: String) {
        self.titleLabel.text = name
        if photo != "" {
            self.thumbImg.kf.setImage(with: URL(string: photo))
        }
        self.locationLabel.text = location
        self.inforLabel.text = "\(date) - \(goingCount) them gia"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
