//
//  DependencyContainer.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/4/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

protocol ModuleFactory {
    func makeMainViewController(with input: MainInput) -> MainViewController
    func makeGoogleMapsViewController() -> MapViewController
}

protocol DependecyFactory {
    func makeLocationService() -> LocationServiceProtocol
    func makeNetworkService() -> NetworkServiceProtocol
}

final class Container {  }

//MARK: ModuleFactory
extension Container: ModuleFactory {
    
    func makeMainViewController(with input: MainInput) -> MainViewController {
        let viewController = UIStoryboard.Main.mainVC
        let mailManager = MailManager()
        let presenter = MainViewPresenter(manager: mailManager)
        let parent = input.parentCoordinator
        let router: RouterType = Router(navigationController: parent.router.navigationController)
        let coordinator = MainViewControllerCoordinator(with: router, dependencies: Container())
        viewController.presenter = presenter
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    func makeGoogleMapsViewController() -> MapViewController {
        let viewController = UIStoryboard.GoogleMaps.googleMapsVC
        let locationManager = LocationManager()
        let presenter = GoogleMapsPresenter(location: locationManager)
        viewController.presenter = presenter
        
        return viewController
    }
    
}
