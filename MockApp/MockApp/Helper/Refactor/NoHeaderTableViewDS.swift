//
//  TableViewDatasource.swift
//  MockApp
//
//  Created by tund on 3/12/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class NoHeaderTableViewDS: NSObject, UITableViewDataSource {
    var arrEvent = [Event]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UITableViewCell()
            
        }
        let photo = self.arrEvent[indexPath.row].getPhoto()
        let name = self.arrEvent[indexPath.row].getName()
        let startDate = self.arrEvent[indexPath.row].getStartDate()
        let endDate = self.arrEvent[indexPath.row].getEndDate()
        let descHtml = self.arrEvent[indexPath.row].getDescHtml()
        let goingCount = self.arrEvent[indexPath.row].getGoingCount()
        let permanent = self.arrEvent[indexPath.row].getPermanent()
        let myStatus = self.arrEvent[indexPath.row].getMyStatus()
        cell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, myStatus)
        cell.delegate = self
        cell.id = self.arrEvent[indexPath.row].getId()
        return cell
    }
    
}
extension NoHeaderTableViewDS: EventCellDelegate {
    func onClick(_ id: Int) {
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            eventDetailVC.id = id
            appDelegate.tabbar?.present(eventDetailVC, animated: true, completion: nil)
        }
    }
}
