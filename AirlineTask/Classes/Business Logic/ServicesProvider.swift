//
//  ServicesProvider.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class ServicesProvider {
    static let instance = ServicesProvider()
    private static let operationQueue = OperationQueue()
    
    let cities = CitiesService(operationQueue)
    let weather = WeatherService(operationQueue)
    
    private init() { }
}
