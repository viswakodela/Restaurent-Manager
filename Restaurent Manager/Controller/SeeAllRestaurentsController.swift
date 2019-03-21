//
//  SeeAllRestaurentsController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/13/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import MapKit

class SeeAllRestaurentsController: UIViewController {
    
    private let seeAllCellID = "seeAllCellID"
    private let mapViewAnnotationID = "mapViewAnnotationID"
    
    var businesses = [Business]()
    var currentLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var bottomViewTopContraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheet()
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        ai.hidesWhenStopped = true
        return ai
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        return mapView
    }()
    
    let bottomViewController = BottomSheetController()
    
    func setupLayout() {
        
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func addBottomSheet() {
        
        guard let bottomView = bottomViewController.view else {return}
        bottomView.backgroundColor = .red
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(bottomViewController)
        view.addSubview(bottomView)
        
        let width = view.frame.width
        let height = view.frame.height
        
        bottomView.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
        
    }
    
    func checkMobileSettingsLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func fetchData() {
        APIService.shared.nearByLocation(location: self.currentLocation, businessCount: 50) { [weak self](businesses) in
            self?.activityIndicatorView.stopAnimating()
            self?.businesses = businesses
            
            self?.bottomViewController.businesses = businesses
            
            self?.businesses.forEach({ (business) in
                let title = business.name
                let latitude = CLLocationDegrees(business.coordinates.latitude)
                let longitude = CLLocationDegrees(business.coordinates.longitude)
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let annotation = CustomPin(pinTitle: title, pinSubTitle: "", coordinate: coordinates)
                self?.mapView.addAnnotation(annotation)
                self?.mapView.showAnnotations((self?.mapView.annotations)!, animated: true)
            })
        }
    }
}


class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = coordinate
    }
}

extension SeeAllRestaurentsController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: mapViewAnnotationID)
        annotationView?.image = #imageLiteral(resourceName: "icons8-marker-100-2")
        annotationView?.canShowCallout = true
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
}
