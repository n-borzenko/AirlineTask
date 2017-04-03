//
//  CityTypes.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

enum CityTypes {
    case arrival
    case departure
    
    var imageName: String {
        switch self {
        case .departure: return "GlobalDepartureCity"
        case .arrival: return "GlobalArrivalCity"
        }
    }
    
    var placeholder: String {
        switch self {
        case .departure: return "Откуда"
        case .arrival: return "Куда"
        }
    }
}
