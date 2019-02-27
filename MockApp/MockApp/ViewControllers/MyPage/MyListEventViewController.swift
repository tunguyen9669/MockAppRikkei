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
    // MAR: - outlet, actions and variable
    @IBOutlet weak var goingContainer: UIView!
    @IBOutlet weak var goingSegment: SegmentView!
    @IBOutlet weak var wentSegment: SegmentView!
    @IBOutlet weak var wentContainer: UIView!
    var goingVC: GoingViewController?
    var wentVC: WentViewController?
    var countTapGoing = 1
    var countTapWent = 1

    
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
                                        NotificationCenter.default.post(name: Notification.Name.kLogout, object: nil, userInfo: ["type": "logout"])
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
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        goingSegment.setSelected(true)
        wentSegment.setSelected(false)
        goingContainer.isHidden = false
        wentContainer.isHidden = true
        
        // click on Tab
        goingSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGoingView(_:))))
        wentSegment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapWentView(_:))))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("mylist prepare")
        if segue.identifier == "going" {
            if let goingVC = segue.destination as? GoingViewController {
                self.goingVC = goingVC
            }
        }else if segue.identifier == "went" {
            if let wentVC = segue.destination as? WentViewController {
                self.wentVC = wentVC
            }
        }
    }
    
    // MARK: - function
    @objc func onTapGoingView(_ sender: UITapGestureRecognizer) {
        if let wentVC = self.wentVC {
            wentVC.countTap = 0
        }
        goingSegment.setSelected(true)
        wentSegment.setSelected(false)
        goingContainer.isHidden = false
        wentContainer.isHidden = true
        if let goingVC = self.goingVC  {
            goingVC.countTap += 1
            print("Going: \(goingVC.countTap)")
        }
        print("Tap Going")
    }
    @objc func onTapWentView(_ sender: UITapGestureRecognizer) {
        if let goingVC = self.goingVC  {
            goingVC.countTap = 0
        }
        goingSegment.setSelected(false)
        wentSegment.setSelected(true)
        goingContainer.isHidden = true
        wentContainer.isHidden = false
        if let wentVC = self.wentVC {
            wentVC.countTap += 1
        }
        print("Tap Went")
    }
    
}
