//
//  CityViewModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class CityViewModel {
    var latitude: Double
    var longitude: Double
    var name: String
    var airports: String = "Все аэропорты"
    
    init(with model: City) {
        latitude = model.latitude
        longitude = model.longitude
        name = model.name
    }
}
