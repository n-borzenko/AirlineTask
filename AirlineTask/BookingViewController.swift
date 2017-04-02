//
//  FlightConditionsViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class BookingViewController: BaseBlueViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bookingView: MainBookingView!
    let selectCitySegueId = "SelectCity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingView.delegate = self
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
    }
    
    @IBAction func searchFlights(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == selectCitySegueId {
            let destinationVC = (segue.destination as! UINavigationController).viewControllers[0] as! CityViewController
            destinationVC.currentCity = "Мск"
        }
    }
    
    @IBAction func unwindToBooking(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! CityViewController
        print(sourceVC.currentCity!)
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
