//
//  Translations.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

enum WindDirection {
    case nord, nordEast, east, sudEast, sud, sudWest, west, nordWest
    
    var description: String {
        switch self {
        case .nord: return "С"
        case .nordEast: return "СВ"
        case .east: return "В"
        case .sudEast: return "ЮВ"
        case .sud: return "Ю"
        case .sudWest: return "ЮЗ"
        case .west: return "З"
        case .nordWest: return "СЗ"
        }
    }
    
    init(degrees: Double) {
        switch degrees {
        case 22.5..<67.5: self = .nordEast
        case 67.5..<112.5: self = .east
        case 112.5..<157.5: self = .sudEast
        case 157.5..<202.5: self = .sud
        case 202.5..<247.5: self = .sudWest
        case 247.5..<292.5: self = .west
        case 292.5..<337.5: self = .nordWest
        default: self = .nord
        }
    }
}

class Translator {
    
    
    func pressure(hectopascal: Double) -> Double {
        return hectopascal * 0.75006375541921
    }
}
