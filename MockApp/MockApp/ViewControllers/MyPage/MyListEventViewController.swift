//
//  MyListEventViewController.swift
//  MockApp
//
//  Created by tund on 2/20/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class MyListEventViewController: UIViewController {
    
    @IBAction func onDetailEvent(_ sender: Any) {
        if let detailVC = R.storyboard.myPage.eventDetailViewController() {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        let title = "Thông báo"
        let msg = "Bạn có chắc chắn muốn đăng xuất?"
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Đồng ý",
                                     style: .destructive) { (_ ) in
                                        UserPrefsHelper.shared.setIsloggined(false)
                                        UserPrefsHelper.shared.setUserToken("")
                                        if let registerVC = R.storyboard.myPage.registerViewController() {
                                            self.navigationController?.pushViewController(registerVC, animated: true)
                                        }
        }
        let cancelAction = UIAlertAction(title: "Huỷ bỏ",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.tabbar?.setHidden(false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
