//
//  WeatherTableViewCell.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var pressureImageView: UIImageView!
    @IBOutlet weak var windImageView: UIImageView!
    @IBOutlet weak var dropImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let pressureImage = UIImage(named: "Pressure")!.withRenderingMode(.alwaysTemplate)
        pressureImageView.image = pressureImage
        let windImage = UIImage(named: "Wind")!.withRenderingMode(.alwaysTemplate)
        windImageView.image = windImage
        let dropImage = UIImage(named: "Drop")!.withRenderingMode(.alwaysTemplate)
        dropImageView.image = dropImage
    }
}
