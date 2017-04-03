//
//  FlightConditionsViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class BookingViewController: BaseBlueViewController {

    var errorController = ErrorViewController()
    var errorWindow: UIWindow!
    
    var presentationModel = BookingPresentationModel()
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bookingView: MainBookingView!
    @IBOutlet weak var forwardDateView: TravelDateView!
    @IBOutlet weak var backwardDateView: ReturnDateComponentView!
    @IBOutlet weak var passengerView: PassengersList!
    
    let selectDepartureCitySegueId = "SelectDepartureCity"
    let selectArrivalCitySegueId = "SelectArrivalCity"
    let showWeatherSegueId = "ShowWeather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentationModel.delegate = self
        bookingView.delegate = self
        passengerView.delegate = self
        forwardDateView.delegate = self
        backwardDateView.delegate = self
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 55)
        errorWindow = UIWindow.init(frame: frame)
        errorWindow.rootViewController = errorController
        errorWindow.windowLevel = UIWindowLevelStatusBar
        errorWindow.isHidden = true
        
        bookingView.update(with: presentationModel.viewModel)
        passengerView.update(with: presentationModel.viewModel)
        forwardDateView.update(date: presentationModel.viewModel.forwardDate)
        backwardDateView.update(date: presentationModel.viewModel.backwardDate)
    }
    
    @IBAction func searchFlights(_ sender: Any) {
        if presentationModel.validateAll() {
            performSegue(withIdentifier: showWeatherSegueId, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == selectDepartureCitySegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! CityViewController
            destinationVC.presentationModel.cityType = .departure
            destinationVC.presentationModel.selectedCity = presentationModel.viewModel.departureCity
        }
        
        if segue.identifier == selectArrivalCitySegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! CityViewController
            destinationVC.presentationModel.cityType = .arrival
            destinationVC.presentationModel.selectedCity = presentationModel.viewModel.arrivalCity
        }
        
        if segue.identifier == showWeatherSegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! WeatherViewController
            
            destinationVC.forwardController.presentationModel.city = presentationModel.viewModel.departureCity
            destinationVC.backwardController.presentationModel.city = presentationModel.viewModel.arrivalCity
            destinationVC.isOneWay = presentationModel.viewModel.backwardDate == nil
        }
    }
    
    @IBAction func unwindToBooking(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! CityViewController
        
        if let city = sourceVC.presentationModel.selectedCity {
            switch sourceVC.presentationModel.cityType! {
            case .departure: presentationModel.viewModel.departureCity = city
            case .arrival: presentationModel.viewModel.arrivalCity = city
            }
            bookingView.update(with: presentationModel.viewModel)
        }
    }
}

extension BookingViewController: BookingPresentationDelegate {
    func showError(message: String = "") {
        errorWindow.isHidden = false
        errorController.show(message) { [unowned self] in
            self.errorWindow.isHidden = true
        }
    }
    
    func updatePassengers() {
        passengerView.update(with: presentationModel.viewModel)
    }
}

extension BookingViewController: MainBookingViewDelegate {
    func selectDepartureCity() {
        performSegue(withIdentifier: selectDepartureCitySegueId, sender: self)
    }
    
    func selectArrivalCity() {
        performSegue(withIdentifier: selectArrivalCitySegueId, sender: self)
    }
    
    func swapCities() {
        presentationModel.swapCities()
        bookingView.update(with: presentationModel.viewModel)
    }
}

extension BookingViewController: DateComponentDelegate {
    func beginSelecting(_ travelDateView: TravelDateView) {
        let calendarController = CalendarViewController()
        calendarController.modalTransitionStyle = .crossDissolve
        calendarController.modalPresentationStyle = .overFullScreen
        calendarController.delegate = self
        
        switch travelDateView.direction {
        case .forward:
            calendarController.startDate = presentationModel.viewModel.forwardDate
        case .backward:
            if let date =  presentationModel.viewModel.backwardDate {
                calendarController.startDate = date
            } else {
                calendarController.startDate = presentationModel.viewModel.forwardDate
            }
        }
        presentationModel.calendarDirection = travelDateView.direction
        present(calendarController, animated: true, completion: nil)
    }
    
    func clear(_ returnDateView: ReturnDateComponentView) {
        presentationModel.viewModel.backwardDate = nil
    }
}

extension BookingViewController: CalendarControllerDelegate {
    func checkDate(_ date: Date) -> Bool {
        guard let direction = presentationModel.calendarDirection,
            presentationModel.validate(date, for: direction) else {
                return false
        }
        
        switch direction {
        case .forward:
            presentationModel.viewModel.forwardDate = date
            forwardDateView.update(date: presentationModel.viewModel.forwardDate)
        case .backward:
            presentationModel.viewModel.backwardDate = date
            backwardDateView.update(date: presentationModel.viewModel.backwardDate)
        }
        presentationModel.calendarDirection = nil
        return true
    }
    
    func clearDateDirection() {
        presentationModel.calendarDirection = nil
    }
}

extension BookingViewController: PassengersListDelegate {
    func tryChange(to value: Int, for type: PassengerType) {
        presentationModel.tryChange(to: value, for: type)
    }
}
