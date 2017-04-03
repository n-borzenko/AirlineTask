//
//  TravelTabsViewDelegate.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import Foundation

protocol TravelTabsViewDelegate: class {
    func selectedTab(_ direction: TravelDirection)
}
