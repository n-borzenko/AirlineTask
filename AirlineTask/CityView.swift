//
//  CityView.swift
//  AirlineTask
//
//  Created by n-borzenko on 31.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class CityView: UIView {

    var cityLabel: UILabel!
    var airportsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        cityLabel = UILabel()
        cityLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        cityLabel.textColor = UIColor.white
        cityLabel.text = "Москва"
        addSubview(cityLabel)
        
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        airportsLabel = UILabel()
        airportsLabel.font = UIFont.systemFont(ofSize: 14.0)
        airportsLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        airportsLabel.text = "Все аэропорты"
        addSubview(airportsLabel)
        
        airportsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        airportsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        airportsLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        airportsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 49)
    }
}
