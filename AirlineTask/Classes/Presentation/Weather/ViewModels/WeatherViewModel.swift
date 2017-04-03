//
//  WeatherViewModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    var iconName: String
    var description: String
    var temperature: String
    var humidity: String
    var pressure: String
    var wind: String
    var time: String
    var date: String
    
    init(with model: WeatherData) {
        iconName = model.types[0].icon
        description = model.types[0].description
        humidity = "\(Int(round(model.main.humidity))) %"
        
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .hour, value: 3, to: model.date)!
        // date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, EEEEEE"
        date = dateFormatter.string(from: startDate)
        
        // time
        dateFormatter.dateFormat = "HH:mm"
        time = dateFormatter.string(from: startDate)
        
        // temperature
        let numberFormatter = NumberFormatter()
        var number = NSNumber(value: model.main.temperature)
        numberFormatter.positivePrefix = "+"
        temperature = numberFormatter.string(from: number)!

        // pressure
        let pressureValue = WeatherViewModel.convertPressure(hectopascal: model.main.pressure)
        pressure = "\(Int(round(pressureValue))) мм рт. ст."
        
        // wind
        numberFormatter.positivePrefix = ""
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        number = NSNumber(value: model.wind.speed)
        let speedValue = numberFormatter.string(from: number)!
        let direction = WindDirection.init(degrees: model.wind.degrees)
        wind = "\(speedValue) м/c, \(direction.description)"
    }
    
    private static func convertPressure(hectopascal: Double) -> Double {
        return hectopascal * 0.75006375541921
    }
}
