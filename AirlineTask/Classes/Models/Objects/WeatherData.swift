//
//  WeatherData.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherData {
    var date: Date!
    var wind: Wind!
    var main: MainWeatherData!
    var types: [WeatherType]!
}

extension WeatherData: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        date <- (map["dt"], DateTransform())
        wind <- map["wind"]
        main <- map["main"]
        types <- map["weather"]
    }
    
    func validate() -> Bool {
        guard types != nil else {
            return false
        }
        for type in types {
            if !type.validate() {
                return false
            }
        }
        return date != nil && wind != nil && main != nil
    }
}
