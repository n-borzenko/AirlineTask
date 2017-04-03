//
//  CityTableViewCell.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityView: CityView!
    
    func fill(with viewModel: CityViewModel) {
        cityView.airportsLabel.text = viewModel.airports
        cityView.cityLabel.text = viewModel.name
    }
}
