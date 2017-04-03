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
    var calendarDirection: TravelDirection?
    
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
        
        guard valideteDates(forward: viewModel.forwardDate, backward: viewModel.backwardDate) else {
            return false
        }
        
        return validatePassengers(adults: viewModel.passengers, kids: viewModel.kids, babies: viewModel.babies)
    }
    
    func validate(_ date: Date, for direction: TravelDirection) -> Bool {
        switch direction {
        case .forward:
            return valideteDates(forward: date, backward: viewModel.backwardDate)
        case .backward:
            return valideteDates(forward: viewModel.forwardDate, backward: date)
        }
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
    
    private func valideteDates(forward: Date, backward: Date?) -> Bool {
        let calendar = Calendar.current
        let limitDate = calendar.date(byAdding: .year, value: 1, to: Date())!
        let today = calendar.startOfDay(for: Date())
        let forwardDate = calendar.startOfDay(for: forward)
        
        guard forwardDate.timeIntervalSince1970 <= limitDate.timeIntervalSince1970 else {
            delegate?.showError(message: "Дата Туда должна быть в пределах одного года от текущей")
            return false
        }
        
        guard forwardDate.timeIntervalSince1970 >= today.timeIntervalSince1970 else {
            delegate?.showError(message: "Дата Туда должна быть не раньше сегодняшней даты")
            return false
        }
        
        if let backward = backward {
            let backwardDate = calendar.startOfDay(for: backward)
            
            guard backwardDate.timeIntervalSince1970 <= limitDate.timeIntervalSince1970 else {
                delegate?.showError(message: "Дата Обратно должна быть в пределах одного года от текущей")
                return false
            }
            
            guard forwardDate.timeIntervalSince1970 <= backwardDate.timeIntervalSince1970 else {
                delegate?.showError(message: "Дата Обратно должна быть не раньше даты Туда")
                return false
            }
        }
        return true
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
