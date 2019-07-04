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
    func makeMainViewController() -> MainViewController
    func makeGoogleMapsViewController() -> MapViewController
    func makeNoLocationViewController() -> NoLocationViewController
}

final class DependencyContainer {  }

extension DependencyContainer: ModuleFactory {
    
    func makeMainViewController() -> MainViewController {
        let viewController = UIStoryboard.Main.mainVC
        let viewModel = MainViewModel()
        viewController.viewModel = viewModel
        
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
