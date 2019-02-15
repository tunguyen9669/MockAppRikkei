//
//  HomeViewController.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var newsSegment: SegmentView!
    @IBOutlet weak var popularSegment: SegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsSegment.setSelected(true)
        popularSegment.setSelected(false)
        
        // click on Tab
        newsSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapNewsView(_:))))
        popularSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPopularView(_:))))
        
    }
    
    // MARK: - function
    @objc func onTapNewsView(_ sender: UITapGestureRecognizer) {
        newsSegment.setSelected(true)
        popularSegment.setSelected(false)
        print("Tap News")
    }
    @objc func onTapPopularView(_ sender: UITapGestureRecognizer) {
        newsSegment.setSelected(false)
        popularSegment.setSelected(true)
        print("Tap Popular")
    }
}
