//
//  BaseViewController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
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
    
    let dispatchGroup = DispatchGroup()
    func searchByLocation() {
        
        var group1: [Business]?
        var group2: [Business]?
        var group3: [Business]?
        var group4: [Business]?
        
        
        dispatchGroup.enter()
        APIService.shared.nearByLocation(location: self.currentLocation, businessCount: 10) { [weak self] (businesses) in
            print("Done with nearBy Resturents")
            group1 = businesses
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.allRestaurentsInTheCity(location: self.currentLocation) { [weak self] (businesses) in
            print("Done with all the Restaurents")
            group2 = businesses
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.localBoatings(location: self.currentLocation) { [weak self] (businesses) in
            print("Donw with local Boating")
            group3 = businesses
            self?.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        APIService.shared.localBowlings(location: self.currentLocation) { [weak self] (businesses) in
            print("Done with local Bowling")
            group4 = businesses
            self?.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            print("Finish Fetching")
            self?.restaurents.append(group1!)
            self?.restaurents.append(group2!)
            self?.restaurents.append(group3!)
            self?.restaurents.append(group4!)
            self?.collectionView.reloadData()
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
            cell.seeAllButton.addTarget(self, action: #selector(handleSeeAllButton), for: .touchUpInside)
            cell.seeAllButton.tag = indexPath.item
            return cell
        } else if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.secondHorizontalCellID, for: indexPath) as! SecondHorizontalCell
            cell.businesses = self.restaurents[indexPath.item]
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.secondHorizontalCellID, for: indexPath) as! SecondHorizontalCell
            let business = self.restaurents[indexPath.item]
            cell.businesses = business
            if let location = business.first?.location?.city {
                cell.titleLabel.text = "Boating events in \(location)"
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseViewController.secondHorizontalCellID, for: indexPath) as! SecondHorizontalCell
            let business = self.restaurents[indexPath.item]
            cell.businesses = business
            if let location = business.first?.location?.city {
                cell.titleLabel.text = "Bowling events in \(location)"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        
        if indexPath.item == 0 {
            return CGSize(width: width, height: 230)
        } else if indexPath.item == 1 {
            return CGSize(width: width, height: 230)
        } else {
            return CGSize(width: width, height: 230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseViewController.headerCellID, for: indexPath) as! HeaderViewCell
        return header
    }
    
    @objc func handleSeeAllButton(button: UIButton) {
        let seeAllRestaurents = SeeAllRestaurentsController()
//        seeAllRestaurents.businesses = self.restaurents[button.tag]
        
        let bottomSheet = BottomSheetController()
        bottomSheet.businesses = self.restaurents[button.tag]
        bottomSheet.collectionView.reloadData()
        
        seeAllRestaurents.currentLocation = self.currentLocation
        navigationController?.pushViewController(seeAllRestaurents, animated: true)
    }
    
}
