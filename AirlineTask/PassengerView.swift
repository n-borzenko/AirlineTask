//
//  PassengerView.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

enum PassengerType {
    case adult
    case kid
    case baby
}

extension PassengerType {
    var defaultValue: Int {
        switch self {
        case .adult: return 1
        case .kid: return 0
        case .baby: return 0
        }
    }
    
    var imageName: String {
        switch self {
        case .adult: return "BookingPerson"
        case .kid: return "BookingKid"
        case .baby: return "BookingBaby"
        }
    }
    
    var description: String {
        switch self {
        case .adult: return "Взрослый"
        case .kid: return "2-12 лет"
        case .baby: return "до 2-х лет"
        }
    }
}

@IBDesignable
class PassengerView: UIView {
    
    var addButton: UIButton!
    var removeButton: UIButton!
    var countLabel: UILabel!
    
    var passengerType = PassengerType.adult
    var count = 0 {
        didSet {
            animateChanges()
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

    func createSubviews() {
        let bundle = Bundle(for: PassengerView.self)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 16.0
        
        addButton = UIButton()
        let plusImage = UIImage(named: "BookingPlus", in: bundle, compatibleWith: traitCollection)
        addButton.setBackgroundImage(plusImage, for: .normal)
        addButton.tintColor = UIColor.white
        addSubview(addButton)

        let countStackView = UIStackView()
        countStackView.axis = .horizontal
        countStackView.alignment = .lastBaseline
        countStackView.distribution = .fillProportionally
        countStackView.spacing = 8.0
        countLabel = UILabel()
        count = passengerType.defaultValue
        countLabel.text = "\(count)"
        countLabel.font = UIFont.systemFont(ofSize: 26.0)
        countLabel.textColor = UIColor.white
        let passengerIcon = UIImage(named: passengerType.imageName, in: bundle, compatibleWith: traitCollection)
        let passengerImageView = UIImageView(image: passengerIcon)
        passengerImageView.contentMode = .bottom
        passengerImageView.tintColor = UIColor.white
        countStackView.addArrangedSubview(countLabel)
        countStackView.addArrangedSubview(passengerImageView)
        
        let descriptionStackView = UIStackView()
        descriptionStackView.axis = .vertical
        descriptionStackView.alignment = .leading
        descriptionStackView.distribution = .fillProportionally
        let titleLabel = UILabel()
        titleLabel.text = passengerType.description
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor.white
        descriptionStackView.addArrangedSubview(countStackView)
        descriptionStackView.addArrangedSubview(titleLabel)
        
        removeButton = UIButton()
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
        if count < 9 {
          count += 1
        }
    }
    
    func removePassenger() {
        if count > 0 {
            count -= 1
        }
    }
    
    func animateChanges() {
        countLabel.text = "\(count)"
        
        let totalDuration = 2.0
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
        
//
//        UIView.animateKeyframes(withDuration: totalDuration, delay: 0.0, options: [],
//                                animations: { [unowned self] in
//
//            var t = 0.0
//            let dt = 1.0 / Double(totalCount - 1)
//            
//            var previousWidth = self.countLabel.frame.width
//            var previousHeight = self.countLabel.frame.height
//            
//            for i in 0..<totalCount {
//                
//                let delta = CGFloat(self.animationFunction(p: t))
//                print(delta)
//                
//                let newWidth = previousWidth + delta
//                let newHeight = previousHeight + delta
//                
//                UIView.addKeyframe(withRelativeStartTime: Double(i) * duration, relativeDuration: duration, animations: { [unowned self] in
//                    self.countLabel.transform = CGAffineTransform(scaleX: newWidth / previousWidth, y: newHeight / previousHeight)
//                })
//                t += dt
//                previousWidth = newWidth
//                previousHeight = newHeight
//            }
//            
//            
//        }, completion: nil)
        

//            CGFloat w = fromSize.width + function(t) * (toSize.width - fromSize.width);
//            CGFloat h = fromSize.height + function(t) * (toSize.height - fromSize.height);

        
        
    }
    
    
    
    func animationFunction(p: Double) -> Double {
        return sin(13 * M_PI_2 * p) * pow(2, 10 * (p - 1));
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 120)
    }
}
