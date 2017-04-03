//
//  ReturnDateComponentView.swift
//  AirlineTask
//
//  Created by n-borzenko on 31.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class ReturnDateComponentView: UIView {
    
    var dateView: TravelDateView!
    var addDateButton: UIButton!
    var removeButton: UIButton!
    
    weak var delegate: DateComponentDelegate?
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            changeState()
        }
    }

    init(isSelected: Bool) {
        self.isSelected = isSelected
        super.init(frame: CGRect.zero)
        createSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        let bundle = Bundle(for: ReturnDateComponentView.self)
        let cornerRaduis: CGFloat = 10.0
        
        dateView = TravelDateView(direction: .backward)
        dateView.delegate = self
        
        addSubview(dateView)
        dateView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dateView.translatesAutoresizingMaskIntoConstraints = false

        addDateButton = UIButton()
        addDateButton.tintColor = UIColor.white
        let addImage = UIImage(named: "BookingAdd", in: bundle, compatibleWith: traitCollection)
        addDateButton.setImage(addImage, for: .normal)
        
        let addString = NSAttributedString(
            string: TravelDirection.backward.description,
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0),
                         NSForegroundColorAttributeName: UIColor.white])
        addDateButton.setAttributedTitle(addString, for: .normal)
        addDateButton.titleEdgeInsets.left = 10
        addDateButton.imageEdgeInsets.right = 10
        
        addDateButton.layer.borderWidth = 1.0
        addDateButton.layer.borderColor = UIColor.white.cgColor
        addDateButton.layer.cornerRadius = cornerRaduis / 2
        
        addSubview(addDateButton)
        addDateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addDateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addDateButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        addDateButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addDateButton.translatesAutoresizingMaskIntoConstraints = false
        
        removeButton = UIButton()
        let removeImage = UIImage(named: "GlobalDelete", in: bundle, compatibleWith: traitCollection)
        removeButton.setImage(removeImage, for: .normal)
        removeButton.layer.borderColor = UIColor.white.cgColor
        removeButton.layer.borderWidth = 1.0
        removeButton.layer.cornerRadius = cornerRaduis
        removeButton.tintColor = UIColor.white
        removeButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        addSubview(removeButton)
        removeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        removeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        removeButton.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 15).isActive = true
        removeButton.centerYAnchor.constraint(equalTo: dateView.centerYAnchor).isActive = true
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        changeState()
        addDateButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
    }
    
    func update(date: Date?) {
        if let date = date {
            isSelected = true
            dateView.update(date: date)
        } else {
            isSelected = false
        }
    }
    
    func addAction() {
        delegate?.beginSelecting(dateView)
    }
    
    func removeAction() {
        isSelected = false
        delegate?.clear(self)
    }
    
    private func changeState() {
        dateView.isHidden = !isSelected
        addDateButton.isHidden = isSelected
        removeButton.isHidden = !isSelected
    }
}

extension ReturnDateComponentView: TravelDateViewDelegate {
    func beginSelecting(_ travelDateView: TravelDateView) {
        delegate?.beginSelecting(travelDateView)
    }
}
