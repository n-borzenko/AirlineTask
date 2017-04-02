//
//  MainBookingView.swift
//  AirlineTask
//
//  Created by n-borzenko on 31.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class MainBookingView: UIView {

    var departureCity: CityView!
    var arrivalCity: CityView!
    var swapCitiesButton: UIButton!
    
    weak var delegate: MainBookingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        let bundle = Bundle(for: MainBookingView.self)

        let departureImage = UIImage(named: "GlobalDepartureCity", in: bundle, compatibleWith: traitCollection)!
        let departureImageView = UIImageView(image: departureImage)
        departureImageView.contentMode = .scaleAspectFit
        departureImageView.tintColor = UIColor.white
        
        addSubview(departureImageView)
        departureImageView.heightAnchor.constraint(equalToConstant: 9).isActive = true
        departureImageView.widthAnchor.constraint(equalToConstant: 9).isActive = true
        departureImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        departureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        departureCity = CityView()
        addSubview(departureCity)
        departureCity.leadingAnchor.constraint(equalTo: departureImageView.trailingAnchor, constant: 10).isActive = true
        departureCity.topAnchor.constraint(equalTo: topAnchor).isActive = true
        departureCity.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        departureCity.translatesAutoresizingMaskIntoConstraints = false
        departureImageView.centerYAnchor.constraint(equalTo: departureCity.cityLabel.centerYAnchor).isActive = true
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSubview(lineView)
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.leadingAnchor.constraint(equalTo: departureCity.leadingAnchor).isActive = true
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        swapCitiesButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let swapImage = UIImage(named: "BookingCityChange", in: bundle, compatibleWith: traitCollection)!
        swapCitiesButton.setImage(swapImage, for: .normal)
        swapCitiesButton.tintColor = UIColor.white
        
        let borderLayer = CALayer()
        let borderLength = CGFloat(sqrt(2.0) * 20)
        borderLayer.bounds = CGRect(x: swapCitiesButton.bounds.minX, y: swapCitiesButton.bounds.minY, width: borderLength, height: borderLength)
        borderLayer.borderColor = UIColor.white.cgColor
        borderLayer.borderWidth = 1.0
        borderLayer.cornerRadius = 5.0
        
        let degrees = 45.0
        let radians = CGFloat(degrees * Double.pi / 180)
        borderLayer.position = CGPoint(x: 20, y: 20)
        borderLayer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        borderLayer.backgroundColor = Colors.lightBlue.cgColor
        swapCitiesButton.layer.insertSublayer(borderLayer, below: swapCitiesButton.imageView?.layer)
        
        addSubview(swapCitiesButton)
        swapCitiesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        swapCitiesButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        swapCitiesButton.topAnchor.constraint(equalTo: departureCity.bottomAnchor).isActive = true
        swapCitiesButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        swapCitiesButton.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.centerYAnchor.constraint(equalTo: swapCitiesButton.centerYAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: swapCitiesButton.centerXAnchor).isActive = true
        
        arrivalCity = CityView()
        addSubview(arrivalCity)
        arrivalCity.topAnchor.constraint(equalTo: swapCitiesButton.bottomAnchor).isActive = true
        arrivalCity.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        arrivalCity.translatesAutoresizingMaskIntoConstraints = false
        
        let arrivalImage = UIImage(named: "GlobalArrivalCity", in: bundle, compatibleWith: traitCollection)!
        let arrivalImageView = UIImageView(image: arrivalImage)
        arrivalImageView.contentMode = .scaleAspectFit
        arrivalImageView.tintColor = UIColor.white
        
        addSubview(arrivalImageView)
        arrivalImageView.heightAnchor.constraint(equalToConstant: 9).isActive = true
        arrivalImageView.widthAnchor.constraint(equalToConstant: 9).isActive = true
        arrivalImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        arrivalImageView.centerYAnchor.constraint(equalTo: arrivalCity.cityLabel.centerYAnchor).isActive = true
        arrivalImageView.translatesAutoresizingMaskIntoConstraints = false
        arrivalCity.leadingAnchor.constraint(equalTo: arrivalImageView.trailingAnchor, constant: 10).isActive = true

        let routeImage = UIImage(named: "GlobalRoute", in: bundle, compatibleWith: traitCollection)!
        let routeImageView = UIImageView(image: routeImage)
        routeImageView.tintColor = UIColor.white
        routeImageView.contentMode = .center
        
        addSubview(routeImageView)
        routeImageView.widthAnchor.constraint(equalToConstant: 9).isActive = true
        routeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        routeImageView.topAnchor.constraint(equalTo: departureImageView.bottomAnchor).isActive = true
        routeImageView.bottomAnchor.constraint(equalTo: arrivalImageView.topAnchor).isActive = true
        routeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        swapCitiesButton.addTarget(self, action: #selector(swapCities), for: .touchUpInside)
        
        let departureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectDepartureCity(sender:)))
        departureCity.addGestureRecognizer(departureRecognizer)
        let arrivalRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectArrivalCity(sender:)))
        arrivalCity.addGestureRecognizer(arrivalRecognizer)
        
        arrivalCity.cityLabel.text = "Москва"
        departureCity.cityLabel.text = "Калининград"
    }
    
    @objc private func selectArrivalCity(sender: UITapGestureRecognizer) {
        delegate?.selectArrivalCity()
    }
    
    @objc private func selectDepartureCity(sender: UITapGestureRecognizer) {
        delegate?.selectDepartureCity()
    }
    
    @objc private func swapCities() {
        let tempCity = arrivalCity.cityLabel.text
        arrivalCity.cityLabel.text = departureCity.cityLabel.text
        departureCity.cityLabel.text = tempCity
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 350, height: 150)
    }
}
