//
//  ErrorViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 02.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    let movingDuration = 0.5
    let totalDuration = 5.0
    var currentTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let errorImage = UIImage(named: "GlobalDelete")!.withRenderingMode(.alwaysTemplate)
        errorImageView.image = errorImage
        errorImageView.contentMode = .center
        errorImageView.layer.borderWidth = 2.0
        errorImageView.layer.borderColor = UIColor.white.cgColor
        errorImageView.layer.cornerRadius = errorImageView.frame.height / 2
    }
    
    func show(_ message: String = "", completion: @escaping () -> Void) {
        if let timer = currentTimer {
            timer.invalidate()
        }
        if view.frame.minY == 0 {
            view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        }
        
        errorLabel.text = message
        UIView.animate(withDuration: movingDuration, animations: { [unowned self] in
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        let duration = totalDuration - movingDuration
        currentTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [unowned self] _ in
            UIView.animate(withDuration: self.movingDuration, animations: { [unowned self] in
                self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }, completion: { _ in
                completion()
            })
        }
    }
}
