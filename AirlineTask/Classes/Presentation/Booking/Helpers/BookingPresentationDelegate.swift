//
//  BookingPresentationDelegate.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

protocol BookingPresentationDelegate: class {
    func showError(message: String)
    func updatePassengers()
}
