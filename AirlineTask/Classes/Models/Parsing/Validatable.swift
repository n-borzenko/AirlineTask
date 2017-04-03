//
//  ValidateProtocol.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Validatable: Mappable {
    func validate() -> Bool
}
