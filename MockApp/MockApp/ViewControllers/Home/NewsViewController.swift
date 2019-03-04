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
    let realmManager =  RealmManager.shared
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
        appDelegate.tabbar?.setHidden(false)
        
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataCheckToday()
        checkDataDB()
        getDataFromDB()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    // MARK: - function
    
    func checkDataDB() {
        guard let arrNewsDB = realmManager.getObjects(NewsRealmModel.self)?.toArray(ofType: NewsRealmModel.self) else {
            return
        }
        print("Check data in db")
        if arrNewsDB.count == 0 {
            // get data from api
            getNewsList(1) { (news) in
                self.creatDB(news: news)
            }
        }
    }
    
    func getDataFromDB() {
        self.arrNews.removeAll()
        guard let arrNewsDB = realmManager.getObjects(NewsRealmModel.self)?.toArray(ofType: NewsRealmModel.self) else {
            return
        }
        
        
        // update index for load more
        self.pageIndex = arrNewsDB.count / 10
        
        
        print("Load từ News DB")
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
   
    func getDataCheckToday() {
        self.arrNews.removeAll()
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getNewsList(1) { (news) in
                self.creatDB(news: news)
                self.arrNews = news
                self.reloadTable()
            }
            print("Load từ News API")
        } else {
          //
        }
    }
    
    // refresh data
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataFromDB()
        refreshControl.endRefreshing()
    }
    
    func creatDB(news: [News]) {
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
            realmManager.editObject(news)
        }
    }


    func reloadTable() {
        self.arrNews = self.arrNews.sorted { (news1, news2) -> Bool in
            return news1.getPublishDate().convertStringToMilisecond() >= news2.getPublishDate().convertStringToMilisecond()
        }
        self.tableView.reloadData()
        self.tableView.contentOffset = .zero
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
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
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
        if Connectivity.isConnectedToInternet {
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
                    self.creatDB(news: news)
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
                
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
      
    }
    
    
}
