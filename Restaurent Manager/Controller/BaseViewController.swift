//
//  BaseViewController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import MapKit
import Alamofire

class BaseViewController: UICollectionViewController {
    
    
    private static let restaurentCellId = "restaurentCellId"
    private static let headerCellID = "headerCellID"
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    private let appKey = "0XAQ_rCntdHlMH_Xr3PI_ogYCwus-iQS_076dy1KucqWW6RR7WKdFICk-i3YYsu2APA3Zy6yWYAYh71auoDzvYygDu1b2yOHJTJPGUTOB6nU2TNhRUBZ_T0qNbl6XHYx"
    var restaurents = [Business]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        setupLayout()
    }
    
    func checkPermission() {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            checkLocationAuthorization()
        } else {
            print("Check the location Services")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //locationManager.requestWhenInUseAuthorization()
            locationManager?.requestLocation()
            break
        case .authorizedWhenInUse:
            locationManager?.requestLocation()
            break
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            break
        case .denied:
            break
        default:
            break
        }
    }
    
    func searchByLocation() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        let geoCoder = CLGeocoder()
        guard let currentLocation = self.currentLocation else {return}
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { [weak self](placemarks, err) in
            let presentLocation = placemarks?.first?.name
            
            let parameters = ["term": "restaurants", "location": presentLocation ?? ""] as Parameters
            let header: HTTPHeaders = ["Authorization": "Bearer \(self?.appKey ?? "")"]
            
            let url = "https://api.yelp.com/v3/businesses/search"
            Alamofire.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
                
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                guard let restaurents = result?.businesses else {return}
                self?.restaurents = restaurents
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            })
        }
    }
    
    func setupLayout() {
        collectionView.alwaysBounceVertical = true
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BaseViewController.headerCellID)
        collectionView.register(RestaurentsCell.self, forCellWithReuseIdentifier: BaseViewController.restaurentCellId)
    }
    
    
}

extension BaseViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.first?.coordinate
        searchByLocation()
    }
}

extension BaseViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.restaurentCellId, for: indexPath) as! RestaurentsCell
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseViewController.headerCellID, for: indexPath) as! HeaderViewCell
        return header
    }
    
}
