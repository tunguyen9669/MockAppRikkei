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
    let locationManager = CLLocationManager()

    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fsPagerView.register(UINib(nibName: "EventPagerCell", bundle: nil), forCellWithReuseIdentifier: "EventPagerCell")
        
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        self.fsPagerView.reloadData()
        
        // map
        mapView.delegate = self
        self.getNearlyEvents(1000.0, -122.123161, 37.891628) { (events) in
            self.reloadFsPager(events)
            self.showPartyMarkers(events)
        }
        setupMap(-122.123161, 37.891628)
        
        locationManager.delegate = self
        notificationAction()
       
        
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: self.fsPagerView.frame.size.height)
        self.fsPagerView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(false)
        
       locationManager.requestWhenInUseAuthorization()  
    }
    
    // MARK: - function
    
    func showPartyMarkers(_ events: [Event]) {
        mapView.clear()
        for i in 0..<events.count {
            if let lat = Float(events[i].venue.getLat()),
                let long = Float(events[i].venue.getLong()) {
                let marker = GMSMarker()
                marker.icon = R.image.red_anotation()
                marker.title = "\(events[i].venue.getName()) \n \(events[i].getDistance()) km"
                marker.userData = i
                marker.position = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(long))
                marker.map = self.mapView
            }
        }
    }
    
    func setupMap(_ longitude: Float, _ latitude: Float){
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude), zoom: 10.0)
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
    
    func reloadFsPager(_ arr: [Event]) {
        self.arr.removeAll()
        self.arr += arr
        self.arr = self.arr.sorted { (po1, po2) -> Bool in
            return po1.getGoingCount() >= po2.getGoingCount()
        }
        self.fsPagerView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - function
    
    func notificationAction() {
        // bug
        NotificationCenter.default.addObserver(self, selector: #selector(onGoing(_:)), name: .kUpdateGoingEvent, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onWent(_:)), name: .kUpdateWentEvent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .kLogout, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onGetNewData(_:)), name: .kLogin, object: nil)
    }
    
    
    @objc func onLogout(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getNearlyEvents(1000.0, -122.123161, 37.891628) { (events) in
                self.reloadFsPager(events)
                self.showPartyMarkers(events)
            }
        }
        
    }
    
    @objc func onGetNewData(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getNearlyEvents(1000.0, -122.123161, 37.891628) { (events) in
                self.reloadFsPager(events)
                self.showPartyMarkers(events)
            }
        }
    }
    // bug
    
    @objc func onGoing(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            print("Near da nhan Going")
            var events = self.arr
            for i in 0..<self.arr.count {
                if events[i].getId() == popular.getId() {
                    events[i].myStatus = 1
                }
            }
            self.fsPagerView.reloadData()
        }
    }
//
    @objc func onWent(_ sender: Notification) {
        if let popular = sender.userInfo?["popular"] as? Event {
            print("Near da nhan went")
            var events = self.arr
            for i in 0..<self.arr.count {
                if arr[i].getId() == popular.getId() {
                    events[i].myStatus = 2
                }
            }
            self.fsPagerView.reloadData()
        }

    }
    
}
// MARK: - extension

// fspagerview
extension NearViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arr.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "EventPagerCell", at: index)
        guard let aCell = cell as? EventPagerCell else {
            return FSPagerViewCell()
        }
        let photo = self.arr[index].getPhoto()
        let name = self.arr[index].getName()
        let startDate = self.arr[index].getStartDate()
        let endDate = self.arr[index].getEndDate()
        let descHtml = self.arr[index].getDescHtml()
        let goingCount = self.arr[index].getGoingCount()
        let permanent = self.arr[index].getPermanent()
        let myStatus = self.arr[index].getMyStatus()
        aCell.customInit(photo, name, descHtml, startDate, endDate, goingCount, permanent, myStatus)
//        aCell.delegate = self
//        aCell.id = populars[indexPath.row].getId()
        return aCell
    }
    
    public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let long = Float(self.arr[index].venue.getLong()),
            let lat = Float(self.arr[index].venue.getLat()) {
            let id = self.arr[index].getId()
            setupMap(long, lat)
            if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
                eventDetailVC.id = id
                self.navigationController?.pushViewController(eventDetailVC, animated: true)
            }
        }
        
    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        let index = pagerView.currentIndex
        if let long = Float(self.arr[index].venue.getLong()),
            let lat = Float(self.arr[index].venue.getLat()) {
            setupMap(long, lat)
            
        }
    }
    
}

// location
extension NearViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        // get location now, now is fake
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 10.0, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

// mapview
extension NearViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let data = marker.userData as? Int {
            self.fsPagerView.scrollToItem(at: data, animated: true)
            if let long = Float(self.arr[data].venue.getLong()),
                let lat = Float(self.arr[data].venue.getLat()) {
                print("\(long) \(lat)")
                setupMap(long, lat)
            }
        }
        return true
    }
    
}
