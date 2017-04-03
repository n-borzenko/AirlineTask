//
//  DateComponentDelegate.swift
//  AirlineTask
//
//  Created by n-borzenko on 03.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

protocol DateComponentDelegate: TravelDateViewDelegate {
    func clear(_ returnDateView: ReturnDateComponentView)
}
