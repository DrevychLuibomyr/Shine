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
    func makeNoLocationViewController() -> NoLocationViewController
}

protocol DependecyFactory {
    func makeLocationService() -> LocationServiceProtocol
    func makeNetworkService() -> NetworkServiceProtocol
}

final class DependencyContainer {  }

extension DependencyContainer: DependecyFactory {
    
    func makeLocationService() -> LocationServiceProtocol {
        return LocationManager()
    }
    
    func makeNetworkService() -> NetworkServiceProtocol {
        return NetworkManager()
    }
}

//MARK: ModuleFactory
extension DependencyContainer: ModuleFactory {
    
    func makeMainViewController(with input: MainInput) -> MainViewController {
        let viewController = UIStoryboard.Main.mainVC
        let viewModel = MainViewModel()
        let parent = input.parentCoordinator
        let router: RouterType = Router(navigationController: parent.router.navigationController)
        let coordinator = MainViewControllerCoordinator(with: router, dependencies: DependencyContainer())
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        
        return viewController
    }
    
    func makeGoogleMapsViewController() -> MapViewController {
        let viewController = UIStoryboard.GoogleMaps.googleMapsVC
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let viewModel = MapViewModel(netwrok: networkManager, location: locationManager)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func makeNoLocationViewController() -> NoLocationViewController {
        let viewController = UIStoryboard.NoLocation.noLocationVC
        
        return viewController
    }
    
    
}
