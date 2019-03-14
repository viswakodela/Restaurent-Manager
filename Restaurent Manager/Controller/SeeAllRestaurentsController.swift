//
//  SeeAllRestaurentsController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/13/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import MapKit

class SeeAllRestaurentsController: UICollectionViewController {
    
    private static let seeAllCellID = "seeAllCellID"
    
    var businesses = [Business]()
    var currentLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchData()
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    func locationManage() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func setupLayout() {
        
        view.backgroundColor = .white
        
        
        
//        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
//        collectionView.register(SeeAllRestaurentsCell.self, forCellWithReuseIdentifier: SeeAllRestaurentsController.seeAllCellID)
//        
//        self.view.addSubview(activityIndicatorView)
//        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func fetchData() {
        APIService.shared.nearByLocation(location: self.currentLocation, businessCount: 40) { [weak self](businesses) in
            self?.activityIndicatorView.stopAnimating()
            self?.businesses = businesses
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SeeAllRestaurentsController: UICollectionViewDelegateFlowLayout {
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return businesses.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeAllRestaurentsController.seeAllCellID, for: indexPath) as! SeeAllRestaurentsCell
//        let business = self.businesses[indexPath.item]
//        cell.business = business
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 32)
//        return CGSize(width: width, height: 200)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let business = self.businesses[indexPath.item]
//
//    }
    
}

extension SeeAllRestaurentsController: CLLocationManagerDelegate {
    
}
