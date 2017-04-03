//
//  WeatherTableViewCell.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var pressureImageView: UIImageView!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var dropImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let pressureImage = UIImage(named: "Pressure")!.withRenderingMode(.alwaysTemplate)
        pressureImageView.image = pressureImage
        let windImage = UIImage(named: "Wind")!.withRenderingMode(.alwaysTemplate)
        windImageView.image = windImage
        let dropImage = UIImage(named: "Drop")!.withRenderingMode(.alwaysTemplate)
        dropImageView.image = dropImage
        weatherImageView.image = nil
    }
    
    func fill(with viewModel: WeatherViewModel) {
        timeLabel.text = viewModel.time
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        pressureLabel.text = viewModel.pressure
        windLabel.text = viewModel.wind
        humidityLabel.text = viewModel.humidity
        
        if let image = UIImage(named: viewModel.iconName) {
            weatherImageView.image = image
        } else {
             weatherImageView.image = nil
        }
    }
}
