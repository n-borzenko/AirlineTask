//
//  PassengerView.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class PassengerView: UIView {
    
    weak var delegate: PassengerViewDelegate?
    
    var addButton = UIButton()
    var removeButton = UIButton()
    var countLabel = UILabel()
    var passengerImageView = UIImageView()
    var titleLabel = UILabel()
    
    var passengerType = PassengerType.adult
    var needAnimation = false
    var count = 0 {
        willSet {
            if newValue == count {
                needAnimation = false
            }
        }
        didSet {
            if count == 0 && isEnabled == true {
                isEnabled = false
            } else if count > 0 && isEnabled == false {
                isEnabled = true
            }
            
            if needAnimation {
                animateChanges()
            }
            needAnimation = true
        }
    }
    
    init(type: PassengerType) {
        passengerType = type
        super.init(frame: CGRect.zero)
        createSubviews()
    }
    
    override init(frame: CGRect) {
        passengerType = .adult
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        passengerType = .adult
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    var isEnabled = true {
        didSet {
            if isEnabled {
                addButton.tintColor = UIColor.white
                passengerImageView.tintColor = UIColor.white
                removeButton.tintColor = UIColor.white
                titleLabel.textColor = UIColor.white
                countLabel.textColor = UIColor.white
            } else {
                addButton.tintColor = UIColor.white.withAlphaComponent(0.5)
                passengerImageView.tintColor = UIColor.white.withAlphaComponent(0.5)
                removeButton.tintColor = UIColor.white.withAlphaComponent(0.5)
                titleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
                countLabel.textColor = UIColor.white.withAlphaComponent(0.5)
            }
        }
    }

    func createSubviews() {
        let bundle = Bundle(for: PassengerView.self)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 16.0
        
        let plusImage = UIImage(named: "BookingPlus", in: bundle, compatibleWith: traitCollection)
        addButton.setBackgroundImage(plusImage, for: .normal)
        addButton.tintColor = UIColor.white
        addSubview(addButton)

        let countStackView = UIStackView()
        countStackView.axis = .horizontal
        countStackView.alignment = .lastBaseline
        countStackView.distribution = .fillProportionally
        countStackView.spacing = 8.0
        count = passengerType.defaultValue
        countLabel.text = "\(count)"
        countLabel.font = UIFont.systemFont(ofSize: 26.0)
        countLabel.textColor = UIColor.white
        let passengerIcon = UIImage(named: passengerType.imageName, in: bundle, compatibleWith: traitCollection)
        passengerImageView.image = passengerIcon
        passengerImageView.contentMode = .bottom
        passengerImageView.tintColor = UIColor.white
        countStackView.addArrangedSubview(countLabel)
        countStackView.addArrangedSubview(passengerImageView)
        
        let descriptionStackView = UIStackView()
        descriptionStackView.axis = .vertical
        descriptionStackView.alignment = .leading
        descriptionStackView.distribution = .fillProportionally
        titleLabel.text = passengerType.description
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor.white
        descriptionStackView.addArrangedSubview(countStackView)
        descriptionStackView.addArrangedSubview(titleLabel)
        
        let minusImage = UIImage(named: "BookingMinus", in: bundle, compatibleWith: traitCollection)
        removeButton.setBackgroundImage(minusImage, for: .normal)
        removeButton.tintColor = UIColor.white
        mainStackView.addArrangedSubview(addButton)
        mainStackView.addArrangedSubview(descriptionStackView)
        mainStackView.addArrangedSubview(removeButton)
        
        addSubview(mainStackView)

        mainStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        addButton.addTarget(self, action: #selector(addPassenger), for: .touchUpInside)
        
        removeButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 12).isActive = true
        removeButton.addTarget(self, action: #selector(removePassenger), for: .touchUpInside)
    }
    
    func addPassenger() {
        delegate?.tryUpdate(self, to: count + 1)
    }
    
    func removePassenger() {
        if count > 0 {
            delegate?.tryUpdate(self, to: count - 1)
        }
    }
    
    func animateChanges() {
        countLabel.text = "\(count)"
        
        let totalDuration = 1.0
        let totalCount = 3
        let duration = Double(totalDuration) / Double(totalCount)
        
        UIView.animateKeyframes(
            withDuration: totalDuration,
            delay: 0.0,
            options: [],
            animations: { [unowned self] in
                
                UIView.addKeyframe(withRelativeStartTime: 0 * duration, relativeDuration: duration, animations: { [unowned self] in
                    self.countLabel.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                })
                UIView.addKeyframe(withRelativeStartTime: 1 * duration, relativeDuration: duration, animations: { [unowned self] in
                    self.countLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                })
                UIView.addKeyframe(withRelativeStartTime: 2 * duration, relativeDuration: duration, animations: { [unowned self] in
                    self.countLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
                
            }, completion: nil)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 120)
    }
}
