//
//  BookingViewModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class BookingViewModel {
    
    var passengers = 1
    var kids = 0
    var babies = 2
    
    var forwardDate = Date()
    var backwardDate: Date?
    
    var departureCity: CityViewModel?
    var arrivalCity: CityViewModel?
}
