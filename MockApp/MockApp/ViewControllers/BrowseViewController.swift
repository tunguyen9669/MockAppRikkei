//
//  BrowseViewController.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit

class BrowseViewController: UIViewController {
    
    // MARK: - outlet, action and variable
    
    @IBOutlet weak var tableView: UITableView!
    var categories = [Category]()
    let realmManager = RealmManager.shared
    @IBAction func onSearch(_ sender: Any) {
        //
    }
    let services = BrowseService()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BrowseViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tabbarColor
        
        return refreshControl
    }()
    var pageIndex = 1
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        self.tableView.addSubview(self.refreshControl)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.estimatedRowHeight = 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
        getDataCheckToday()
        checkDataDB()
        getDataFromDB()
        
    }
    
    // MARK: - function
    
    func checkDataDB() {
        self.categories.removeAll()
        guard let arrDB = realmManager.getObjects(CategoryRealmModel.self)?.toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        
        print("check data in db")
        
        if arrDB.count == 0 {
            // get data from api
            self.getCategories(1) { (categories) in
                self.creatDB(categories: categories)
                self.categories = categories
                self.tableView.reloadData()
            }
        }
    }
    
    func creatDB(categories: [Category]) {
        for item in categories {
            let category = CategoryRealmModel()
            category.id = item.getId()
            category.name = item.getName()
            category.slug = item.getSlug()
            category.parentId = item.getParentId()
            realmManager.editObject(category)
            
        }
    }
    
    func getDataFromDB() {
        self.categories.removeAll()
        guard let arrDB = realmManager.getObjects(CategoryRealmModel.self)?.toArray(ofType: CategoryRealmModel.self) else {
            return
        }
        print("Load từ Browse DB")
        
        self.pageIndex = arrDB.count / 15
        
        for item in arrDB {
            let category = Category()
            category.id  = item.id
            category.name = item.name
            category.slug = item.slug
            category.parentId = item.parentId
            self.categories.append(category)
        }
        self.tableView.reloadData()
    }
    
    func getDataCheckToday() {
        self.categories.removeAll()
        let keyUpdate = UserPrefsHelper.shared.getKeyUpdateNews()
        if keyUpdate.isToday() == false {
            print("Load từ listcategory API")
            UserPrefsHelper.shared.setkeyUpdateNews(self.getDateNow())
            self.getCategories(1) { (categories) in
                self.creatDB(categories: categories)
                self.categories = categories
                self.tableView.reloadData()
            }
        } else {
            //
        }
    }
    
    // refresh data
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getDataFromDB()
        refreshControl.endRefreshing()
    }

    
    func getCategories(_ pageIndex: Int, _ completion: @escaping([Category]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestGetListCategory(pageIndex, completion: { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let result):
                    var arr: [Category] = []
                    for item in result {
                        arr.append(Category(item))
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

// MARK: - extension

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as?  CategoryCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = self.categories[indexPath.row].getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more
        if Connectivity.isConnectedToInternet {
            if indexPath.row == self.categories.count - 1 {
                print("load more")
                if pageIndex < 10 {
                    self.pageIndex += 1
                }
                self.getCategories(pageIndex) { (categories) in
                    var arr: [Category] = []
                    for item in categories {
                        arr.append(item)
                    }
                    self.categories += arr
                    self.creatDB(categories: categories)
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
                
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
        
    }
    
    
}
