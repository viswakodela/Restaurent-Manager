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
    private static let secondHorizontalCellID = "secondHorizontalCellID"
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    var restaurents = [[Business]]()
    
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
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.nearByLocation(location: self.currentLocation) { [weak self] (businesses) in
            dispatchGroup.leave()
            self?.restaurents.append(businesses)
        }
        
        dispatchGroup.enter()
        APIService.shared.allRestaurentsInTheCity(location: self.currentLocation) { [weak self] (businesses) in
            dispatchGroup.leave()
            self?.restaurents.append(businesses)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func setupLayout() {
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BaseViewController.headerCellID)
        collectionView.register(RestaurentsCell.self, forCellWithReuseIdentifier: BaseViewController.restaurentCellId)
        collectionView.register(SecondHorizontalCell.self, forCellWithReuseIdentifier: BaseViewController.secondHorizontalCellID)
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
        return restaurents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.restaurentCellId, for: indexPath) as! RestaurentsCell
            cell.restaurents = self.restaurents[indexPath.item]
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.secondHorizontalCellID, for: indexPath) as! SecondHorizontalCell
            cell.businesses = self.restaurents[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 230)
        } else {
            return CGSize(width: width, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseViewController.headerCellID, for: indexPath) as! HeaderViewCell
        return header
    }
    
}
