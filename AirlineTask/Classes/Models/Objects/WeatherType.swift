//
//  WeatherType.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherType {
    var id: Int!
    var main: String!
    var description: String!
    var icon: String!
}

extension WeatherType: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
    
    func validate() -> Bool {
        return id != nil && main != nil && description != nil && icon != nil
    }
}
