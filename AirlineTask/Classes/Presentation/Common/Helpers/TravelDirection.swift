//
//  TravelDirection.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

enum TravelDirection: String {
    case forward
    case backward
    
    var description: String {
        switch self {
        case .forward: return "Туда"
        case .backward: return "Обратно"
        }
    }
    
    static var allValues: [TravelDirection] {
        return [forward, backward]
    }
}
