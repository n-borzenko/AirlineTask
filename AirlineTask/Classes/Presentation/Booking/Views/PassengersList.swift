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
    
    weak var delegate: PassengersListDelegate?
    
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
        adultsCounter.delegate = self
        kidsCounter = PassengerView(type: .kid)
        kidsCounter.delegate = self
        babiesCounter = PassengerView(type: .baby)
        babiesCounter.delegate = self
        
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
    
    func update(with viewModel: BookingViewModel) {
        if adultsCounter.count != viewModel.passengers {
            adultsCounter.count = viewModel.passengers
        }
        if kidsCounter.count != viewModel.kids {
            kidsCounter.count = viewModel.kids
        }
        if babiesCounter.count != viewModel.babies {
             babiesCounter.count = viewModel.babies
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 120)
    }
}

extension PassengersList: PassengerViewDelegate {
    func tryUpdate(_ passengerView: PassengerView, to value: Int) {
        delegate?.tryChange(to: value, for: passengerView.passengerType)
    }
}
