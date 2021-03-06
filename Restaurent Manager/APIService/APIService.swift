//
//  APIService.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    static let appKey = "0XAQ_rCntdHlMH_Xr3PI_ogYCwus-iQS_076dy1KucqWW6RR7WKdFICk-i3YYsu2APA3Zy6yWYAYh71auoDzvYygDu1b2yOHJTJPGUTOB6nU2TNhRUBZ_T0qNbl6XHYx"
    
    func nearByLocation(location: CLLocationCoordinate2D? = kCLLocationCoordinate2DInvalid, businessCount: Int, completion: @escaping ([Business]) -> ()) {
        let geoCoder = CLGeocoder()
        guard let currentLocation = location else {return}
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
            let presentLocation = placemarks?.first?.postalCode
            let parameters = ["term": "food", "location": presentLocation ?? "", "radius" : 1000, "sort_by" : "distance", "limit" : businessCount] as Parameters
            let header: HTTPHeaders = ["Authorization": "Bearer \(APIService.appKey)"]
            
            let url = "https://api.yelp.com/v3/businesses/search"
            Alamofire.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
//                let dummyString = String(data: data, encoding: .utf8)
//                print(dummyString ?? "")
                
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                guard let restaurents = result?.businesses else {return}
                completion(restaurents)
            })
        }
    }
    
    func allRestaurentsInTheCity(location: CLLocationCoordinate2D?, completion: @escaping ([Business]) -> ()) {
        
        let geoCoder = CLGeocoder()
        guard let currentLocation = location else {return}
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
            let presentLocation = placemarks?.first?.locality
            let parameters = ["term": "food", "location": presentLocation ?? "", "radius" : 40000, "sort_by" : "best_match"] as Parameters
            let header: HTTPHeaders = ["Authorization": "Bearer \(APIService.appKey)"]
            
            let url = "https://api.yelp.com/v3/businesses/search"
            Alamofire.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
//                let dummyString = String(data: data, encoding: .utf8)
//                print(dummyString ?? "")
                
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                guard let restaurents = result?.businesses else {return}
                completion(restaurents)
            })
        }
    }
    
    func localBoatings(location: CLLocationCoordinate2D?, completion: @escaping ([Business]) -> ()) {
        let geoCoder = CLGeocoder()
        guard let currentLocation = location else {return}
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
            let presentLocation = placemarks?.first?.locality
            let parameters = ["location": presentLocation ?? "", "radius" : 40000, "categories" : "boating,All"] as Parameters
            let header: HTTPHeaders = ["Authorization": "Bearer \(APIService.appKey)"]
            
            let url = "https://api.yelp.com/v3/businesses/search"
            Alamofire.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
//                let dummyString = String(data: data, encoding: .utf8)
//                print(dummyString ?? "")
                
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                guard let restaurents = result?.businesses else {return}
                completion(restaurents)
            })
        }
    }
    
    func localBowlings(location: CLLocationCoordinate2D?, completion: @escaping([Business]) -> ()) {
        
        let geoCoder = CLGeocoder()
        guard let currentLocation = location else {return}
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, err) in
            let presentLocation = placemarks?.first?.locality
            let parameters = ["location": presentLocation ?? "", "radius" : 40000, "categories" : "bubblesoccer, All"] as Parameters
            let header: HTTPHeaders = ["Authorization": "Bearer \(APIService.appKey)"]
            
            let url = "https://api.yelp.com/v3/businesses/search"
            Alamofire.request(url, method: .get, parameters: parameters , encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (dataResponse) in
                guard let data = dataResponse.data else {return}
//                let dummyString = String(data: data, encoding: .utf8)
//                print(dummyString ?? "")
                
                let result = try? JSONDecoder().decode(Feed.self, from: data)
                guard let restaurents = result?.businesses else {return}
                completion(restaurents)
            })
        }
    }
    
    func businessDetails(id: String, completion: @escaping (BusinessDetails) -> ()) {
        
        let url = "https://api.yelp.com/v3/businesses/\(id)"
        let header: HTTPHeaders = ["Authorization": "Bearer \(APIService.appKey)"]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).responseData { (dataResponse) in
            guard let data  = dataResponse.data else {return}
//            let dummyString = String(data: data, encoding: .utf8)
//            print(dummyString ?? "")
            let resultData = try? JSONDecoder().decode(BusinessDetails.self, from: data)
            guard let result = resultData else {return}
            completion(result)
        }
    }
    
}
