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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewsViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 270.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arrNews.removeAll()
        
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdateNews()
        
        // check data in DB and update table and time for update News
        if keyUpdate.isToday() == false {
            self.arrNews.removeAll()
            UserPrefsHelper.shared.setkeyUpdateNews(self.getDateNow())
            getNewsList(1) { (news) in
                self.creatDB(news: news)
                self.arrNews = news
                self.reloadTable()
            }
            print("Load từ API")
        } else {
            guard let arrNewsDB = realmManager.getObjects(NewsRealmModel.self)?.toArray(ofType: NewsRealmModel.self) else {
                return
            }
            if arrNewsDB.count  == 0 {
                getNewsList(1) { (news) in
                    self.creatDB(news: news)
                    self.arrNews = news
                    self.reloadTable()
                }
                print(arrNewsDB.count)
            } else {
                print("Load từ DB")
                for item in arrNewsDB {
                    let news = News()
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

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.pageIndex = 1
    }
    
    
    // MARK: - function
    // refresh data
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pageIndex = 1
        guard let arrNewsDB = realmManager.getObjects(NewsRealmModel.self)?.toArray(ofType: NewsRealmModel.self) else {
            return
        }
        self.arrNews.removeAll()
        if arrNewsDB.count  == 0 {
            getNewsList(1) { (news) in
                self.creatDB(news: news)
                self.arrNews = news
                self.reloadTable()
            }
            print(arrNewsDB.count)
        } else { print("Load từ DB")
            for item in arrNewsDB {
                let news = News()
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
        refreshControl.endRefreshing()
    }
    
    func creatDB(news: [News]) {
        realmManager.deleteDabase()
        for item in news {
            let news = NewsRealmModel()
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
    
    func getDateNow() -> Int {
        let date = NSDate()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let min = calendar.component(.minute, from: date as Date)
        let second = calendar.component(.second, from: date as Date)
        let timeNow = "\(year)-0\(month)-\(day) \(hour):\(min):\(second)"
        return timeNow.convertStringToMilisecond()
    }
    
    func getNewsList(_ pageIndex: Int, _ completion: @escaping([News]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetNewsList(pageIndex, completion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr: [News] = []
                    for item in result {
                        arr.append(News(item))
                    }
                    completion(arr)
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                }
            })
        } else {
            AppDelegate.shared.tabbar?.alertWith("Thông báo", "Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
        
    }
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    
    
    
}
// MARK : - extension
extension  NewsViewController : UITableViewDataSource, UITableViewDelegate {
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
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more
        if indexPath.row == self.arrNews.count - 1 {
            print("load more")
            if pageIndex < 20 {
                self.pageIndex += 1
            }
            self.getNewsList(pageIndex) { (news) in
                var arr: [News] = []
                for item in news {
                    arr.append(item)
                }
                self.arrNews += arr
            }
            self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)

        }

    }
    
    
}
