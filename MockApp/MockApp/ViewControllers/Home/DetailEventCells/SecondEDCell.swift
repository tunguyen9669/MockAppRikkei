//
//  SecondEDCell.swift
//  MockApp
//
//  Created by tund on 2/26/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit

protocol SecondEDCellDelegate: class {
    func onFollow()
}

class SecondEDCell: UITableViewCell {
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var gentreLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    weak var delegate: SecondEDCellDelegate?
    
    
    @IBOutlet weak var followButton: UIButton!
    @IBAction func onFollow(_ sender: Any) {
        delegate?.onFollow()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.cornerRadius = 4
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customInit(_ venueName: String,_ gentre: String,_ location: String,_ nameContact: String,_ emailContact: String) {
        self.venueNameLabel.text = venueName
        self.gentreLabel.text = gentre
        self.locationLabel.text = location
        self.contactLabel.text = "\(nameContact) \n \(emailContact)"
    }
    
   
}
