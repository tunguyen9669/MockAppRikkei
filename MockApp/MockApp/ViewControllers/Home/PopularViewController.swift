//
//  PopularViewController.swift
//  MockApp
//
//  Created by tund on 2/18/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class PopularViewController: UIViewController {
    //MARLK: - outlet and variable
    @IBOutlet weak var tableView: UITableView!
    let datasource = NoHeaderTableViewDS()
    
    
    var popular = Event()
    let services = HomeService()
    let realmManager = RealmManager.shared
    var pageIndex = 1
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PopularViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 300.0
        tableView.dataSource = datasource
        appDelegate.tabbar?.setHidden(false)
        notificationAction()
        checkDataDB()
        
       
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataCheckToday()
        getDataFromDB()
   
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func checkDataDB() {
        print("check data in db")
        guard let arrPopular = realmManager.getObjects(EventRealmModel.self)?.toArray(ofType: EventRealmModel.self) else {
            return
        }
        if arrPopular.count == 0 {
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                self.reloadTable(populars)
            }
        }
        
        // get data from API
   
    }
    
    func notificationAction() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .kLogout, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onGetNewData(_:)), name: .kLogin, object: nil)
        
       
    }
    
    @objc func onLogout(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Update status")
            self.getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                print("Popular count: \(populars.count)")
                
                self.reloadTable(populars)
            }
            
        }
     
    }
    
    @objc func onGetNewData(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Update status")
            self.getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
                print("Popular count: \(populars.count)")
                self.reloadTable(populars)
            }
        }
    }
    
    func getDataCheckToday() {
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdatePopular()
        if keyUpdate.isToday() == false {
            UserPrefsHelper.shared.setKeyUpdatePopular(self.getDateNow())
            getPopularList(1) { (populars) in
                self.creatDB(populars: populars)
            }
            print("Load từ  Popular API")
        } else {
            //
        }
    }
    func getDataFromDB() {
        guard let arrPopular = realmManager.getObjects(EventRealmModel.self)?.toArray(ofType: EventRealmModel.self) else {
            return
        }
        
        // update index for load more
        self.pageIndex = arrPopular.count / 10
        
        var arr = [Event]()
        
        print("Load từ event DB")
        for item in arrPopular {
            arr.append(Event(item))
        }
        reloadTable(arr)
        
    }
    
    func reloadTable(_ arr: [Event]) {
        self.datasource.arrEvent = self.sortInArrray(arr)
        self.tableView.reloadData()
        self.tableView.contentOffset = .zero
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataFromDB()
        refreshControl.endRefreshing()
        
    }
    
    func creatDB(populars: [Event]) {
        for item in populars {
            let popular = EventRealmModel(item)
            realmManager.editObject(popular)
        }
        
    }
    
    func getPopularList(_ pageIndex: Int, _ completion: @escaping([Event]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetPopularEvents(pageIndex, completion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr: [Event] = []
                    for item in result {
                        arr.append(Event(item))
                    }
                    completion(arr)
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                    self.alertWith("Fail get data")
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

 // MARK: - extension
extension PopularViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load moreç≈ 
         if Connectivity.isConnectedToInternet {
            if indexPath.row == datasource.arrEvent.count - 1 {
                print("load more")
                if pageIndex < 20 {
                    self.pageIndex += 1
                }

                self.getPopularList(pageIndex) { (populars) in
                    var arr: [Event] = []
                    for item in populars {
                        arr.append(item)
                    }
                    self.datasource.arrEvent += arr
                    self.creatDB(populars: self.datasource.arrEvent)
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
         } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
}


