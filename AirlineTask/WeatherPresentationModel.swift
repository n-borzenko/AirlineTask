//
//  WheatherPresentationModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherPresentationModel {
    
    private let weatherService = ServicesProvider.instance.weather
    
    var data = [[WeatherViewModel]]()
    var headers = [HeaderViewModel]()
    var city: CityViewModel?
    
    weak var delegate: WeatherPresentationDelegate?

    func updateData() {
        guard let city = city else {
            return
        }
        
        weatherService.getWeatherData(
            latitude: city.latitude,
            longitude: city.longitude) { [unowned self] result in
            switch result {
            case .success(let value):
                self.fetchedWeather(items: value)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    private func fetchedWeather(items: [WeatherData]) {
        guard items.count > 0 else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, EEEEEE"
        let date = dateFormatter.string(from: items[0].date)
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: items[0].date)
        headers.append(HeaderViewModel(time: time, date: date))
        
        var index = 0
        data.append([WeatherViewModel]())
        for item in items {
            let viewModel = WeatherViewModel(with: item)
            data[index].append(viewModel)
            if headers.last?.date != viewModel.date {
                headers.append(HeaderViewModel(time: viewModel.time, date: viewModel.date))
                index += 1
                data.append([WeatherViewModel]())
            }
        }
        if data.last!.count == 0 {
            data.removeLast()
            headers.removeLast()
        }
        delegate?.reloadData()
    }
}
