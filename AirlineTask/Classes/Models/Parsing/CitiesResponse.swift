//
//  CitiesResponse.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct CitiesResponse {
    var citiesList: [City]!
}

extension CitiesResponse: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        citiesList <- map["results"]
    }
    
    func validate() -> Bool {
        guard citiesList != nil else {
            return false
        }
        for city in citiesList {
            if !city.validate() {
                return false
            }
        }
        return true
    }
}
