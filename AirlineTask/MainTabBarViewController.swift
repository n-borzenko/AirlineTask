//
//  MainTabBarViewController.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private weak var currentItem: UITabBarItem?
    
    private let standardAttributes = [
        NSFontAttributeName: UIFont.systemFont(ofSize: 12.0),
        NSForegroundColorAttributeName: Colors.lightBlue
    ]
    private let selectedAttributes = [
        NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12.0),
        NSForegroundColorAttributeName: Colors.lightBlue
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes(standardAttributes, for: .normal)
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.white
        
        let tiketsController = UIViewController()
        tiketsController.tabBarItem.title = "Мои билеты"
        let registrationController = UIViewController()
        registrationController.tabBarItem.title = "Регистрация"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookingController = storyboard.instantiateInitialViewController()!
        viewControllers = [tiketsController, registrationController, bookingController]
        
        selectedViewController = bookingController
        bookingController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .normal)

        for controller in viewControllers! {
            controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentItem?.setTitleTextAttributes(standardAttributes, for: .normal)
        currentItem = item
        
        item.setTitleTextAttributes(selectedAttributes, for: .normal)
    }
}
