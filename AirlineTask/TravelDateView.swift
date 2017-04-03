//
//  TravelDateView.swift
//  AirlineTask
//
//  Created by n-borzenko on 31.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class TravelDateView: UIView {

    @IBInspectable var travelDirection: String = "" {
        didSet {
            direction = TravelDirection(rawValue: travelDirection) ?? .forward
        }
    }
    
    var direction: TravelDirection = .forward {
        didSet {
            directionLabel.text = direction.description
        }
    }
    
    weak var delegate: TravelDateViewDelegate?

    var directionLabel: UILabel!
    var dateButton: UIButton!
    
    init(direction: TravelDirection) {
        self.direction = direction
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
        directionLabel = UILabel()
        directionLabel.font = UIFont.systemFont(ofSize: 14.0)
        directionLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        directionLabel.text = direction.description
        
        addSubview(directionLabel)
        directionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        directionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        directionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        directionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateButton = UIButton()
        addSubview(dateButton)
        dateButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dateButton.topAnchor.constraint(equalTo: directionLabel.bottomAnchor).isActive = true
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.addTarget(self, action: #selector(startSelecting), for: .touchUpInside)
    }
    
    func startSelecting() {
        delegate?.beginSelecting(self)
    }
    
    func update(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, EEEEEE"
        let dateString = formatter.string(from: date)
        let title = NSAttributedString(string: dateString, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0), NSForegroundColorAttributeName: UIColor.white])
        dateButton.setAttributedTitle(title, for: .normal)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 90, height: 50)
    }
}
