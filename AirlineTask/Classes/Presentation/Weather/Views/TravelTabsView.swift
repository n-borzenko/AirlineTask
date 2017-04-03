//
//  TravelTabsView.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@IBDesignable
class TravelTabsView: UIView {

    var selectedTab: TravelDirection = .forward {
        didSet {
            switch selectedTab {
            case .forward:
                selectComponent(.backward, state: false)
                selectComponent(.forward, state: true)
            case .backward:
                selectComponent(.forward, state: false)
                selectComponent(.backward, state: true)
            }
        }
    }
    
    @IBInspectable var selectedDirection: String? {
        didSet {
            if let selected = selectedDirection {
                selectedTab = TravelDirection(rawValue: selected) ?? .forward
            }
        }
    }

    @IBInspectable var isForwardEnabled: Bool = true {
        didSet {
            enableComponent(.forward, state: isForwardEnabled)
        }
    }
    
    @IBInspectable var isBackwardEnabled: Bool = true {
        didSet {
            enableComponent(.backward, state: isBackwardEnabled)
        }
    }
    
    class ViewComponents {
        var mainView: UIView?
        var selectorView: UIView?
        var imageView: UIView?
        var titleLabel: UILabel?
        var tapRecognizer: UITapGestureRecognizer?
        
        let titleSize: Int
        let rotateImage: Bool
        let onLeftSide: Bool
        
        init(size: Int, rotate: Bool, onLeft: Bool) {
            titleSize = size
            rotateImage = rotate
            onLeftSide = onLeft
        }
    }
    
    weak var delegate: TravelTabsViewDelegate?
    var components: [TravelDirection: ViewComponents] = [
        .forward: ViewComponents(size: 40, rotate: false, onLeft: true),
        .backward: ViewComponents(size: 70, rotate: true, onLeft: false)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        let bundle = Bundle(for: TravelTabsView.self)
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        addSubview(separatorView)
        separatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        for direction in TravelDirection.allValues {
            let component = components[direction]!
            
            let main = UIView()
            addSubview(main)
            main.topAnchor.constraint(equalTo: topAnchor).isActive = true
            main.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            if component.onLeftSide {
                main.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                main.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor).isActive = true
            } else {
                main.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor).isActive = true
                main.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }
            main.translatesAutoresizingMaskIntoConstraints = false
            component.mainView = main
            
            let contentView = UIView()
            main.addSubview(contentView)
            contentView.topAnchor.constraint(equalTo: main.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: main.bottomAnchor).isActive = true
            contentView.centerXAnchor.constraint(equalTo: main.centerXAnchor).isActive = true
            let contentSize = CGFloat(40 + component.titleSize)
            contentView.widthAnchor.constraint(equalToConstant: contentSize).isActive = true
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            let plane = UIImage(named: "GlobalPlane", in: bundle, compatibleWith: traitCollection)
            let image =  UIImageView(image: plane)
            if component.rotateImage {
                image.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            image.contentMode = .scaleAspectFit
            contentView.addSubview(image)
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            image.heightAnchor.constraint(equalToConstant: 15).isActive = true
            image.widthAnchor.constraint(equalToConstant: 30).isActive = true
            image.translatesAutoresizingMaskIntoConstraints = false
            component.imageView = image
            
            let title = UILabel()
            title.text = direction.description
            contentView.addSubview(title)
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            title.widthAnchor.constraint(equalToConstant: CGFloat(component.titleSize)).isActive = true
            title.translatesAutoresizingMaskIntoConstraints = false
            component.titleLabel = title
            
            let select = UIView()
            select.backgroundColor = Colors.lightBlue
            main.addSubview(select)
            select.leadingAnchor.constraint(equalTo: main.leadingAnchor).isActive = true
            select.trailingAnchor.constraint(equalTo: main.trailingAnchor).isActive = true
            select.bottomAnchor.constraint(equalTo: main.bottomAnchor).isActive = true
            select.heightAnchor.constraint(equalToConstant: 2).isActive = true
            select.translatesAutoresizingMaskIntoConstraints = false
            component.selectorView = select
        }
        
        components[.forward]!.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectForwardTab(sender:)))
        enableComponent(.forward, state: true)
        components[.backward]!.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectBackwardTab(sender:)))
        enableComponent(.backward, state: true)
        selectedTab = .forward
    }
    
    @objc private func selectForwardTab(sender: UITapGestureRecognizer) {
        selectedTab = .forward
        delegate?.selectedTab(.forward)
    }
    
    @objc private func selectBackwardTab(sender: UITapGestureRecognizer) {
        selectedTab = .backward
        delegate?.selectedTab(.backward)
    }
    
    func selectComponent(_ direction: TravelDirection, state: Bool) {
        if let component = components[direction] {
            component.selectorView?.layer.opacity = state ? 1.0 : 0.0
        }
    }
    
    func enableComponent(_ direction: TravelDirection, state: Bool) {
        if let component = components[direction] {
            if state {
                component.mainView?.addGestureRecognizer(component.tapRecognizer!)
                component.imageView?.tintColor = Colors.lightBlue
                component.titleLabel?.textColor = Colors.lightBlue
            } else {
                component.mainView?.removeGestureRecognizer(component.tapRecognizer!)
                component.imageView?.tintColor = UIColor.lightGray
                component.titleLabel?.textColor = UIColor.lightGray
            }
        }
    }
}
