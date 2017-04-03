//
//  PassengerType.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

enum PassengerType {
    case adult
    case kid
    case baby
}

extension PassengerType {
    var defaultValue: Int {
        switch self {
        case .adult: return 1
        case .kid: return 0
        case .baby: return 0
        }
    }
    
    var imageName: String {
        switch self {
        case .adult: return "BookingPerson"
        case .kid: return "BookingKid"
        case .baby: return "BookingBaby"
        }
    }
    
    var description: String {
        switch self {
        case .adult: return "Взрослый"
        case .kid: return "2-12 лет"
        case .baby: return "до 2-х лет"
        }
    }
}
