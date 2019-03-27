//
//  DateHeader.swift
//  MockApp
//
//  Created by tund on 2/25/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
// HaND: Xóa các dòng trắng thừa đi
class DateHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customInit(_ type: String) {
        if type == "Took place" {
            self.titleLabel.text = type
        } else {
            self.titleLabel.text = "End \(type)"
        }
       
    }
    

  
}
