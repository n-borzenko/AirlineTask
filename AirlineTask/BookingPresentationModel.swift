//
//  BookingPresentationModel.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

class BookingPresentationModel {
    weak var delegate: BookingPresentationDelegate?
    
    var viewModel = BookingViewModel()
    let maximumPassengersCount = 9
    
    init() {
        // TODO: - load cities from UserDefaults
    }
    
    func validateAll() -> Bool {
        
        guard viewModel.departureCity != nil else {
            delegate?.showError(message: "Не указано место отправления")
            return false
        }
        
        guard viewModel.arrivalCity != nil else {
            delegate?.showError(message: "Не указано место прибытия")
            return false
        }
        
        return validatePassengers(adults: viewModel.passengers, kids: viewModel.kids, babies: viewModel.babies)
    }
    
    func swapCities() {
        let temp = viewModel.departureCity
        viewModel.departureCity = viewModel.arrivalCity
        viewModel.arrivalCity = temp
    }
    
    func tryChange(to value: Int, for type: PassengerType) {
        guard value >= 0 else {
            return
        }

        switch type {
        case .adult:
            guard value >= 1 else {
                return
            }
            
            if validatePassengers(adults: value, kids: viewModel.kids, babies: viewModel.babies) {
                viewModel.passengers = value
                delegate?.updatePassengers()
            } else if viewModel.babies > value {
                viewModel.babies = value
                viewModel.passengers = value
                delegate?.updatePassengers()
            }
        case .kid:
            if validatePassengers(adults: viewModel.passengers, kids: value, babies: viewModel.babies) {
                viewModel.kids = value
                delegate?.updatePassengers()
            }
        case .baby:
            if validatePassengers(adults: viewModel.passengers, kids: viewModel.kids, babies: value) {
                viewModel.babies = value
                delegate?.updatePassengers()
            }
        }
    }
    
    private func validatePassengers(adults: Int, kids: Int, babies: Int) -> Bool {
        guard adults + kids + babies <= maximumPassengersCount else {
                delegate?.showError(message: "Число пассажиров не должно превышать \(maximumPassengersCount)")
                return false
        }
        
        guard babies <= adults else {
            delegate?.showError(message: "Младенцев должно быть не больше, чем взрослых")
            return false
        }
        
        return true
    }
}
