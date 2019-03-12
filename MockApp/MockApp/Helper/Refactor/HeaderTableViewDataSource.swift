//
//  HeaderTableViewDataSource.swift
//  MockApp
//
//  Created by tund on 3/12/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation

class HeaderTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var arrCommonTables = [CommonTableModel]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrCommonTables.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCommonTables[section].getEvents().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexList = arrCommonTables[indexPath.section].getEvents()[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
            return UITableViewCell()
        }
        cell.customInit(indexList.getPhoto(), indexList.getName(), indexList.getDescHtml(), indexList.getStartDate(), indexList.getEndDate(), indexList.getGoingCount(), indexList.getPermanent(), indexList.getMyStatus())
        cell.delegate = self
        cell.id = arrCommonTables[indexPath.section].getEvents()[indexPath.row].getId()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateHeader") as? DateHeader else {
            return UITableViewHeaderFooterView()
        }
        header.customInit(arrCommonTables[section].getTitle())
        return header
    }
}

extension HeaderTableViewDataSource: EventCellDelegate {
    func onClick(_ id: Int) {
        if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
            eventDetailVC.id = id
            appDelegate.tabbar?.present(eventDetailVC, animated: true, completion: nil)
        }
    }
}
