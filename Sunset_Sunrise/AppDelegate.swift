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
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var applicationCoordinator: ApplicationCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let dependencyContainter = Container()
        let router = Router(navigationController: UINavigationController())
        let appCoordinator = ApplicationCoordinator(with: window, router: router, dependencies: dependencyContainter)
        
        self.applicationCoordinator = appCoordinator
        self.window = window
        
        GMSPlacesClient.provideAPIKey(ApplicationConstants.googlePlaceApiKey)
        GMSServices.provideAPIKey(ApplicationConstants.googlePlaceApiKey)
        
        appCoordinator.start()
        
        return true
    }
    
}

