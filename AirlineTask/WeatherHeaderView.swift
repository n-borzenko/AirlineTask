//
//  WeatherHeaderView.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {

    var timeLabel: UILabel!
    var dateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        timeLabel = UILabel()
        addSubview(timeLabel)
        
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel = UILabel()
        dateLabel.textAlignment = .right
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        dateLabel.textColor = Colors.lightBlue
        addSubview(dateLabel)
    
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 20).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.white
    }
    
    func fill(with viewModel: HeaderViewModel) {
        timeLabel.text = viewModel.time
        dateLabel.text = viewModel.date
    }
}
