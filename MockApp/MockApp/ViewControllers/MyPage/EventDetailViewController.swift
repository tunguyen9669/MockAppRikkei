//
//  EventDetailViewController.swift
//  MockApp
//
//  Created by tund on 2/21/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController {
   
    // MARK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    
    var arrEDs = [EDModel]()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.tabbar?.setHidden(true)
        self.arrEDs.append(EDModel("first"))
        self.tableView.register(UINib(nibName: "FirstEDCell", bundle: nil), forCellReuseIdentifier: "FirstEDCell")
    }
    
}
// MARK: - extension
extension EventDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if self.arrEDs[indexPath.row].getIdentifier() == "first" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstEDCell", for: indexPath) as? FirstEDCell else {
                return UITableViewCell()
            }
            return cell
//        }
    }
    
    
}
