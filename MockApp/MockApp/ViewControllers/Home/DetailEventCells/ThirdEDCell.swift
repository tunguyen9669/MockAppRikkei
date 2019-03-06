//
//  ThirdEDCell.swift
//  MockApp
//
//  Created by tund on 2/26/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import FSPagerView

protocol ThirđEDCellDelegate: class {
    func onGoing()
    func onWent()
    func sendIdItem(_ id: Int)
}

class ThirdEDCell: UITableViewCell {
    
    weak var delegate: ThirđEDCellDelegate?
    
    
    @IBAction func onWent(_ sender: Any) {
        delegate?.onWent()
    }
    
    @IBAction func onGoing(_ sender: Any) {
        delegate?.onGoing()
    }
    @IBOutlet weak var wentButton: UIButton!
    @IBOutlet weak var goingButton: UIButton!
    var id: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
    
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - funtion
    func customInit(_ id: Int) {
        self.id = id
    }
    
}

