//
//  BaseBlueViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class BaseBlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let logoImage = UIImage(named: "GlobalLogo")!
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .center
        logoImageView.tintColor = UIColor.white
        navigationItem.titleView = logoImageView
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

}
