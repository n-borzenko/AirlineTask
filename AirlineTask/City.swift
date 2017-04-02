//
//  City.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct City {
    var name: String!
    var latitude: Double!
    var longitude: Double!
    var id: Int!
}

extension City: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["city"]
        latitude <- map["lon"]
        longitude <- map["lat"]
        id <- map["id"]
    }
    
    func validate() -> Bool {
        return id != nil && name != nil && latitude != nil && longitude != nil
    }
}
