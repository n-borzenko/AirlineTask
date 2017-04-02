//
//  Translations.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation



extension WindDirection {
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
}

class Translator {
    
    
    func pressure(hectopascal: Double) -> Double {
        return hectopascal * 0.75006375541921
    }
}
