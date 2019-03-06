//
//  NearViewController.swift
//  MockApp
//
//  Created by tund on 2/15/19.
//  Copyright © 2019 tund. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView
import GooglePlaces
import GoogleMaps

class NearViewController: UIViewController {
    // MARK: - outlet and variable
    @IBOutlet weak var mapView: GMSMapView!
    
    var arr = [Event]()
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            
        }
    }
    let services = NearService()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fsPagerView.register(UINib(nibName: "EventPagerCell", bundle: nil), forCellWithReuseIdentifier: "EventPagerCell")
        
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        self.fsPagerView.reloadData()
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: self.fsPagerView.frame.size.height)
        self.fsPagerView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
        
        self.getNearlyEvents(1000.0, -122.123161, 37.891628) { (events) in
            self.arr = events
            self.fsPagerView.reloadData()
            self.showPartyMarkers(events)
            print(events.count)
            for item in events {
                print("Location: \(item.venue.getLat()) \(item.venue.getLong())")
            }
        }
        
         initGoogleMaps()
        
       
    }
    
    // MARK: - function
    
    func showPartyMarkers(_ events: [Event]) {
        mapView.clear()
        for item in events {
            if let lat = Float(item.venue.getLat()),
                let long = Float(item.venue.getLong()) {
                let marker = GMSMarker()
                marker.icon = R.image.red_snippet()
                marker.position = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(long))
                marker.map = self.mapView
            }
        }
    }
    
    func initGoogleMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: 45.531334, longitude: -122.830231, zoom: 14.0)
        self.mapView.camera = camera
        self.mapView.isMyLocationEnabled = true
    }
    
    func getNearlyEvents(_ radius: Float, _ longitude: Float, _ latitude: Float,_ completion: @escaping ([Event]) -> Void) {
        if Connectivity.isConnectedToInternet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            services.requestListNearlyEvents(radius, longitude, latitude) { (result) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let events) :
                    var arr = [Event]()
                    for item in events {
                        arr.append(Event(item))
                    }
                    completion(arr)
                case .failure(let error):
                    print("Fail get data")
                    print(error)
                    self.alertWith("Fail get data")
                }
            }
        } else {
            self.alertWith("Không có kết lỗi Internet, vui lòng kiểm tra!")
        }
    }
}
// - extension

extension NearViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "EventPagerCell", at: index)
        guard let aCell = cell as? EventPagerCell else {
            return FSPagerViewCell()
        }
        
        return cell
    }
    
    
    
}
