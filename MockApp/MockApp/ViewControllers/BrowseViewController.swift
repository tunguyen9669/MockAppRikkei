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
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
        // get data from api
        self.getCategories(1) { (categories) in
            self.creatDB(categories: categories)
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
        getDataCheckToday()
        getDataFromDB()
        
    }
    
    // MARK: - function
    
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
    
    
}
