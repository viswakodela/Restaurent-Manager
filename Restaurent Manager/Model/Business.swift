//
//  Restaurent.swift
//  Restaurent Manager
//
//  Created by Viswa Kodela on 3/2/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import Foundation


struct Feed: Decodable {
    var businesses: [Business]
    let total: Int
}

struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    let city: String
    let zip_code: String
    let country: String
    let state: String
}

struct Business: Decodable {
    let id: String
    let name: String
    var image_url: String?
    let rating: Float
    var is_closed: Bool?
    var phone: String?
    var location: Location?
    var price: String?
    var distance: Float?
}
