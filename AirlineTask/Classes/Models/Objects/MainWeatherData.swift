//
//  MainWeatherData.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct MainWeatherData {
    var temperature: Double!
    var pressure: Double!
    var humidity: Double!
}

extension MainWeatherData: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        temperature <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
    
    func validate() -> Bool {
        return temperature != nil && pressure != nil && humidity != nil
    }
}
