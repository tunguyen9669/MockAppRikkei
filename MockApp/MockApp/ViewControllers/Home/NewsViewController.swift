//
//  NewsViewController.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrNews: [News] = []
    let services = HomeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNewsList(1)
    }
    
    func getNewsList(_ pageIndex: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        services.requestGetNewsList(pageIndex, completion: { (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch result {
            case .success(let result):
                for item in result {
                    self.arrNews.append(News(item))
                }
                self.tableView.reloadData()
            case .failure(let error):
                print("Fail get data")
                print(error)
            }
        })
    }
    
    
    
}
extension  NewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
            
        }
        return cell
    }
    
    
}
