//
//  Wind.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Wind {
    var speed: Double!
    var degrees: Double!
}

extension Wind: Validatable {
    init(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        speed <- map["speed"]
        degrees <- map["deg"]
    }
    
    func validate() -> Bool {
        return speed != nil && degrees != nil
    }
}
