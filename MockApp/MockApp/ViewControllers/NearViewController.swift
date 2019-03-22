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
    var MY_LATITUDE: Float = 37.891628
    var MY_LONGITUDE: Float = -122.123161
    var arr = [Event]()
    var markers = [GMSMarker]()
    var fsPagerIndex: Int?
    // set up fspager view
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            
        }
    }
    let services = NearService()
    let locationManager = CLLocationManager()
    var clusterManager: GMUClusterManager!
    
    var ZOOM: Float = 16.0
    
    @IBAction func zoomOut(_ sender: Any) {
        self.ZOOM -= 1
        self.mapView.animate(toZoom: ZOOM)
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        self.ZOOM += 1
        self.mapView.animate(toZoom: ZOOM)
    }
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load")
        // setup fspagerview
        self.fsPagerView.register(UINib(nibName: "EventPagerCell", bundle: nil), forCellWithReuseIdentifier: "EventPagerCell")
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        
        // map
        mapView.delegate = self
        self.getNearlyEvents(1000.0, MY_LONGITUDE, MY_LATITUDE) { (events) in
            self.reloadFsPager(events)
            self.showPartyMarkers(events)
        }
        
        
        setupMap(MY_LONGITUDE, MY_LATITUDE)
        
        locationManager.delegate = self
        notificationAction()
        initializeClusterItems()
    }
    override func viewDidLayoutSubviews() {
        // set up fspagerview
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
    
    // MARK: INITIALIZE CLUSTER ITEMS
    func initializeClusterItems() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUGridBasedClusterAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        self.clusterManager.cluster()
//        self.clusterManager.setDelegate(self as GMUClusterManagerDelegate, mapDelegate: self)
    }
    // MARK: ADD MARKER TO CLUSTER
    func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D, icon: UIImage?) {
        guard let guardIcon = icon else {
            return
        }
        let item = POIItem(position: position, name: accessibilityLabel, icon: guardIcon)
        
        self.clusterManager.add(item)
    }
    
    func showPartyMarkers(_ events: [Event]) {
        
        mapView.clear()
        // find distance min
        var min: Float = events[0].getDistance()
        for item in events {
            if item.getDistance() < min {
                min = item.getDistance()
            }
        }
        // set marker
        for i in 0..<events.count {
            if let lat = Float(events[i].venue.getLat()),
                let long = Float(events[i].venue.getLong()) {
                let marker = GMSMarker()
                // set icon
//                let status = events[i].getMyStatus()
//                if status == 0 {
//                    marker.icon = R.image.gray_anotation()
//                } else if status == 1 {
//                    marker.icon = R.image.red_anotation()
//                } else if status == 2 {
//                    marker.icon = R.image.yellow_anotation()
//                }
//
//                // set high light icon
//                if events[i].getDistance() == min {
//                    if let icon = marker.icon as? UIImage {
//                        marker.icon = self.imageWithImage(image: icon, scaledToSize: CGSize(width: 48.0, height: 48.0))
//                    }
//                }
                
//                let markerViewNew = MarkerView(frame: CGRect(x: 0, y: 0, width: 265, height: 200), index: 1)
//                let markerView = MarkerView(frame: CGRect(x: 0, y: 0, width: 265, height: 200), name: events[i].getName(), photo: events[i].getPhoto(), distance: events[i].getDistance())
                marker.icon = R.image.red_anotation()
                marker.title = "\(events[i].getName()) \n \(events[i].getDistance()) km"
                marker.userData = i
                marker.position = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(long))
                marker.map = mapView
                //                self.generatePOIItems(events[i].getName(), position: marker.position, icon: marker.icon)
                self.markers.append(marker)
            }
            //            self.clusterManager.cluster()
        }
    }
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
    
    func setupMap(_ longitude: Float, _ latitude: Float){
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude), zoom: ZOOM)
        self.mapView.camera = camera
//        if let index = fsPagerIndex {
//            print("Index: \(index)")
//            let marker = self.markers[index]
//            self.mapView.selectedMarker = marker
//        }
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
    
    func reloadFsPager(_ events: [Event]) {
        self.arr.removeAll()
        self.arr += events
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
            self.getNearlyEvents(1000.0, self.MY_LONGITUDE, self.MY_LATITUDE) { (events) in
                self.reloadFsPager(events)
                self.fsPagerView.scrollToItem(at: 0, animated: true)
                self.showPartyMarkers(events)
            }
        }
        
    }
    
    @objc func onGetNewData(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getNearlyEvents(1000.0, self.MY_LONGITUDE, self.MY_LATITUDE) { (events) in
                self.reloadFsPager(events)
                self.fsPagerView.scrollToItem(at: 0, animated: true)
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
            self.MY_LATITUDE = lat
            self.MY_LONGITUDE = long
            self.fsPagerView.scrollToItem(at: index, animated: true)
            if let eventDetailVC = R.storyboard.myPage.eventDetailViewController() {
                eventDetailVC.id = id
                appDelegate.tabbar?.present(eventDetailVC, animated: true, completion: nil)
            }
        }
        
    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        // swipe fspagerview
        let index = pagerView.currentIndex
  
        if let long = Float(self.arr[index].venue.getLong()),
            let lat = Float(self.arr[index].venue.getLat()) {
            setupMap(long, lat)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                let marker = self.markers[index]
//                self.mapView.selectedMarker = marker
//            }
    
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
//        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        guard let location = locations.first else {
        //            return
        //        }
        let location = CLLocation(latitude: CLLocationDegrees(MY_LATITUDE), longitude: CLLocationDegrees(MY_LONGITUDE))
        // get location now, now is fake
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: ZOOM, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

// mapview
extension NearViewController: GMSMapViewDelegate {
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//
//        mapView.selectedMarker = marker
//        if let data = marker.userData as? Int {
//            if let long = Float(self.arr[data].venue.getLong()),
//                let lat = Float(self.arr[data].venue.getLat()) {
//                print("\(long) \(lat)")
//                setupMap(long, lat)
//            }
//        }
//        return true
//    }
    
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let infoView = UIView.loadFromNibNamed(nibNamed: "InforWindowView") as? InforWindowView {
            if let index = marker.userData as? Int {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.fsPagerView.scrollToItem(at: index, animated: true)
                }
                let photo = self.arr[index].getPhoto()
                let name = self.arr[index].getName()
                let distance = self.arr[index].getDistance()
                infoView.customInit(photo, name, distance)
            }
            return infoView
        } else {
            return nil
        }
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
       
        if gesture {
            print("aaaa")
            let latitude = mapView.camera.target.latitude
            let longitude = mapView.camera.target.longitude
            let coordinate0 = CLLocation(latitude: latitude, longitude: longitude)
            let coordinate1 = CLLocation(latitude: CLLocationDegrees(MY_LATITUDE), longitude: CLLocationDegrees(MY_LONGITUDE))
            
            self.MY_LATITUDE = Float(latitude)
            self.MY_LONGITUDE = Float(longitude)
            
            let distanceInMeters = coordinate0.distance(from: coordinate1)
            print(distanceInMeters)
            if distanceInMeters > 1000 {
                self.alertWith("Đã cập nhật lại danh sách do bán kính vượt quá 1000m")
                self.getNearlyEvents(1000.0, MY_LONGITUDE, MY_LATITUDE) { (events) in
                    print(events.count)
                    self.arr = events
                    self.fsPagerView.reloadData()
                    self.showPartyMarkers(events)
                }
            }

        }
    }
   
 
}

//// MARK: - cluster
//extension NearViewController: GMUClusterManagerDelegate {
//    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
//        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
//                                                 zoom: mapView.camera.zoom + 1)
//        let update = GMSCameraUpdate.setCamera(newCamera)
//        mapView.moveCamera(update)
//        return false
//    }
//}
