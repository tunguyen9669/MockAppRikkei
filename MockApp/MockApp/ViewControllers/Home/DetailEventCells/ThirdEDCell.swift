//
//  ThirdEDCell.swift
//  MockApp
//
//  Created by tund on 2/26/19.
//  Copyright © 2019 tund. All rights reserved.
//

import UIKit
import FSPagerView

class ThirdEDCell: UITableViewCell {
    
    var arr = [1, 2, 3, 4, 5, 6]
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.fsPagerView.register(UINib(nibName: "PopularPagerCell", bundle: nil), forCellWithReuseIdentifier: "PopularPagerCell")
        
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        self.fsPagerView.reloadData()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: self.fsPagerView.frame.size.height)
        self.fsPagerView.clipsToBounds = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
// - extension

extension ThirdEDCell: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PopularPagerCell", at: index)
        guard let aCell = cell as? PopularPagerCell else {
            return FSPagerViewCell()
        }
        
        return cell
    }
    
    
}
