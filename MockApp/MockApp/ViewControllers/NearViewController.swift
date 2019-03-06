//
//  NearViewController.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

class NearViewController: UIViewController {
    // MARK: - outlet and variable
    var arr = [1, 2, 3, 4, 5, 6]
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fsPagerView.register(UINib(nibName: "EventPagerCell", bundle: nil), forCellWithReuseIdentifier: "EventPagerCell")
        
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        self.fsPagerView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: self.fsPagerView.frame.size.height)
        self.fsPagerView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
    }
}
// - extension

extension NearViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "EventPagerCell", at: index)
        guard let aCell = cell as? EventPagerCell else {
            return FSPagerViewCell()
        }
        
        return cell
    }
    
    
    
}
