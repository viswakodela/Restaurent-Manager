//
//  BaweViewController.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import CDYelpFusionKit
import MapKit

class BaseViewController: UIViewController {

    var locatonManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        
        locatonManager = CLLocationManager()
        locatonManager?.desiredAccuracy = kCLLocationAccuracyBest
        locatonManager?.delegate = self
        
    }
}

extension BaweViewController: CLLocationManagerDelegate {
    
    
    
}

