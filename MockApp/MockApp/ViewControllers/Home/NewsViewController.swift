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
    // MARK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    var arrNews: [News] = []
    let services = HomeService()
    let realmManager =  NewsRealmManager.shared
    var pageIndex = 1
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let arrNewsDB = realmManager.getObjects(NewsRealmModel.self)?.toArray(ofType: NewsRealmModel.self) else {
            return
        }
       
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdateNews()
        
        // check data in DB and update
        if arrNewsDB.count <= 0 || keyUpdate.isToday() == false {
            getNewsList(pageIndex)
        } else {
            for item in arrNewsDB {
                var news = News()
                news.id  = Int(item.id)
                news.feed = item.feed
                news.title = item.title
                news.detailUrl = item.detailUrl
                news.thumb = item.thumb
                news.desc = item.desc
                news.author = item.author
                news.publishDate = item.publishDate
                news.creatTime = item.creatTime
                news.updateTime = item.updateTime
                self.arrNews.append(news)
            }
            self.reloadTable()
        }

    }
    
    // MARK: - function
    
    func creatDB(news: [News]) {
        realmManager.deleteDabase()
        for item in news {
            var news = NewsRealmModel()
            news.id = item.getId().description
            news.feed = item.getFeed()
            news.title = item.getTitle()
            news.detailUrl = item.getDetailUrl()
            news.thumb = item.getThumb()
            news.desc = item.getDescription()
            news.author = item.getAuthor()
            news.publishDate = item.getPublishDate()
            news.creatTime = item.getCreatTime()
            news.updateTime = item.getUpdateTime()
            realmManager.addObject(obj: news)
        }
    }
    func reloadTable() {
        self.arrNews = self.arrNews.sorted { (news1, news2) -> Bool in
            return news1.getPublishDate().convertStringToMilisecond() >= news2.getPublishDate().convertStringToMilisecond()
        }
        self.tableView.reloadData()
    }
    
    func getNewsList(_ pageIndex: Int) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetNewsList(pageIndex, completion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    for item in result {
                        self.arrNews.append(News(item))
                    }
                    self.creatDB(news: self.arrNews)
                    self.reloadTable()
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                }
            })
        } else {
            AppDelegate.shared.tabbar?.alertWith("Thông báo", "Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
        
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
        let thumb = arrNews[indexPath.row].getThumb()
        let feed = arrNews[indexPath.row].getFeed()
        let title = arrNews[indexPath.row].getTitle()
        let author = arrNews[indexPath.row].getAuthor()
        let publishDate = arrNews[indexPath.row].getPublishDate()
        
        cell.customInit(thumb, title, publishDate, author, feed)
        
        return cell
    }
    
    
}
