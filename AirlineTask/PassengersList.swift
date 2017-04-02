//
//  PassengersList.swift
//  AirlineTask
//
//  Created by n-borzenko on 31.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class PassengersList: UIView {
    
    var totalCount = 0
    var maximumCount = 9
    var maximumBabiesForAdult = 1
    
    var adultsCounter: PassengerView!
    var kidsCounter: PassengerView!
    var babiesCounter: PassengerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .top
        mainStackView.distribution = .equalSpacing
        
        adultsCounter = PassengerView(type: .adult)
        kidsCounter = PassengerView(type: .kid)
        babiesCounter = PassengerView(type: .baby)
        
        mainStackView.addArrangedSubview(adultsCounter)
        mainStackView.addArrangedSubview(kidsCounter)
        mainStackView.addArrangedSubview(babiesCounter)
        
        addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 120)
    }
}