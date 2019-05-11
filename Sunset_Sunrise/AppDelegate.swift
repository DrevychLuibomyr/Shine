//
//  AppDelegate.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    public var navigationRouter: NavigationRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        navController.navigationBar.barTintColor = .black
        navController.navigationBar.tintColor = .white
        navController.navigationBar.barStyle = .black
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationRouter = NavigationRouter(navigationController: navController)
        navigationRouter?.showMainViewController()
        
        window?.rootViewController = navigationRouter?.navigationController
        window?.makeKeyAndVisible()
        
        GMSPlacesClient.provideAPIKey(ApplicationConstants.googlePlaceApiKey)
        GMSServices.provideAPIKey(ApplicationConstants.googlePlaceApiKey)
        
        return true
    }
    
}

