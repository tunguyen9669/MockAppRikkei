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
    // MARK: - outlet and variable
    @IBOutlet weak var newsSegment: SegmentView!
    @IBOutlet weak var popularSegment: SegmentView!
    @IBOutlet weak var newsContainer: UIView!
    @IBOutlet weak var popularContainer: UIView!
    
    
    let services = HomeService()
    var arrNews: [News] = []
    var newsVC: NewsViewController?
    var popularVC: PopularViewController?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newsSegment.setSelected(true)
        popularSegment.setSelected(false)
        newsContainer.isHidden = false
        popularContainer.isHidden = true
        
        // click on Tab
        newsSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapNewsView(_:))))
        popularSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPopularView(_:))))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.tabbar?.setHidden(false)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("home prepare")
//        if segue.identifier == "news" {
//            if let newsVC = segue.destination as? NewsViewController {
//                self.newsVC = newsVC
//                var news = News()
//              
//                
//            
//            }
//        }else if segue.identifier == "popular" {
//            if let popular = segue.destination as? PopularViewController {
//                self.popularVC = popular
//                
//            }
//        }
//    }
    
    // MARK: - function
    @objc func onTapNewsView(_ sender: UITapGestureRecognizer) {
        newsSegment.setSelected(true)
        popularSegment.setSelected(false)
        newsContainer.isHidden = false
        popularContainer.isHidden = true
        print("Tap News")
    }
    @objc func onTapPopularView(_ sender: UITapGestureRecognizer) {
        newsSegment.setSelected(false)
        popularSegment.setSelected(true)
        newsContainer.isHidden = true
        popularContainer.isHidden = false
        print("Tap Popular")
    }
    
   
}
