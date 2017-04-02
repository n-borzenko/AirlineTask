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
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bookingView: MainBookingView!
    let selectCitySegueId = "SelectCity"
    let showWeatherSegueId = "ShowWeather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingView.delegate = self
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        let frame = CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 55)
        errorWindow = UIWindow.init(frame: frame)
        errorWindow.rootViewController = errorController
        errorWindow.windowLevel = UIWindowLevelStatusBar
        errorWindow.isHidden = true
        
    }
    
    @IBAction func searchFlights(_ sender: Any) {
        performSegue(withIdentifier: showWeatherSegueId, sender: self)
    }
    
    func showError(_ message: String = "") {
        errorWindow.isHidden = false
        errorController.show(message) { [unowned self] in
            self.errorWindow.isHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == selectCitySegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! CityViewController
            destinationVC.presentationModel.cityType = .departure
        }
        
        if segue.identifier == showWeatherSegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! WeatherViewController
            
//            destinationVC.forwardController.presentationModel.city = CityViewModel(with: from)
//            destinationVC.backwardController.presentationModel.city = CityViewModel(with: to)
            destinationVC.isOneWay = false
        }
    }
    
    @IBAction func unwindToBooking(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! CityViewController
        
        if let city = sourceVC.presentationModel.selectedCity {
            print(city.name)
        }
    }
}

extension BookingViewController: MainBookingViewDelegate {
    func selectDepartureCity() {
        performSegue(withIdentifier: selectCitySegueId, sender: self)
    }
    
    func selectArrivalCity() {
        performSegue(withIdentifier: selectCitySegueId, sender: self)
    }
}
