//
//  CitiesPresentationModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class CitiesPresentationModel {
    
    private let citiesService = ServicesProvider.instance.cities
    
    var data = [CityViewModel]()
    var filteredData = [CityViewModel]()
    var selectedCity: CityViewModel?
    var cityType: CityTypes!

    weak var delegate: CitiesPresentationDelegate?
    
    func updateData() {
        citiesService.getCities() { [unowned self] result in
            switch result {
            case .success(let value):
                self.fetchedCities(items: value)
            case .failure(_):
                //print(error)
                return
            }
        }
    }
    
    func filterData(_ pattern: String?) {
        if let pattern = pattern {
            filteredData = data.filter { $0.name.lowercased().hasPrefix(pattern) }
        } else {
            filteredData.removeAll()
            filteredData.append(contentsOf: data)
        }
        delegate?.reloadData()
    }
    
    private func fetchedCities(items: [City]) {
        guard items.count > 0 else {
            return
        }
        
        for item in items {
            let viewModel = CityViewModel(with: item)
            data.append(viewModel)
        }
        filteredData.append(contentsOf: data)
        delegate?.reloadData()
    }
}
