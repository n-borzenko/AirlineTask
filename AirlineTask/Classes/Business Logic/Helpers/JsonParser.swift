//
//  JsonParser.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class JsonParser {
    
    func convert<T: Validatable>(string: String) -> T? {
        var mappedObject = T(JSONString: string)
        if let object = mappedObject, !object.validate() {
            mappedObject = nil
        }
        return mappedObject
    }
}
