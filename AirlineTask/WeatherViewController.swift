//
//  WeatherViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 01.04.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var planeImageView: UIImageView!
    @IBOutlet weak var toolBarView: UIToolbar!
    @IBOutlet weak var travelTabsView: TravelTabsView!
    @IBOutlet weak var contentView: UIView!
    
    let forwardController = WeatherListViewController()
    let backwardController = WeatherListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(controller: forwardController)
        travelTabsView.delegate = self
        
        let shadowImage = UIImage(named: "ToolbarBackground")!
        toolBarView.setBackgroundImage(shadowImage, forToolbarPosition: .any, barMetrics: .default)
        
        let planeImage = UIImage(named: "GlobalPlane")!.withRenderingMode(.alwaysTemplate)
        planeImageView.image = planeImage
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func addChild(controller: UIViewController) {
        addChildViewController(controller)
        contentView.addSubview(controller.view)
        controller.view.frame = contentView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParentViewController: self)
    }
    
    fileprivate func removeChild(controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }

}

extension WeatherViewController: TravelTabsViewDelegate {
    func selectedTab(_ direction: TravelDirection) {
        switch direction {
        case .forward:
            removeChild(controller: backwardController)
            addChild(controller: forwardController)
        case .backward:
            removeChild(controller: forwardController)
            addChild(controller: backwardController)
        }
    }
}
