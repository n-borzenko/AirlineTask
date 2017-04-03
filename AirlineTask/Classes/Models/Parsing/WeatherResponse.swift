//
//  WeatherResponse.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherResponse {
    var dataList: [WeatherData]!
}

extension WeatherResponse: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        dataList <- map["list"]
    }
    
    func validate() -> Bool {
        guard dataList != nil else {
            return false
        }
        for data in dataList {
            if !data.validate() {
                return false
            }
        }
        return true
    }
}
