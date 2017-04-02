//
//  AppDelegate.swift
//  AirlineTask
//
//  Created by n-borzenko on 30.03.17.
//  Copyright © 2017 nborzenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = MainTabBarViewController()
        
//        ServicesProvider.instance.cities.getCities { result in
//            switch result {
//            case .success(let cities):
//                for city in cities {
//                    print(city)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
                ServicesProvider.instance.weather.getWeatherData(latitude: 36.869998931884, longitude: 55.7200012207031) { result in
                    switch result {
                    case .success(let weather):
                        for item in weather {
                            print(item)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }

        
        
        window?.makeKeyAndVisible()
        return true
    }
}

