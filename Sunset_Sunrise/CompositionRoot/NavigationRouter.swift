//
//  NavigationRouter.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit

public enum TransitionType {
    case push
    case pop
    case present
    case popToRoot
}

final class NavigationRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func showMainViewController() {
        let mainViewController = MainViewController.instantiateFromStoryboardId(.Main)
        mainViewController.viewModel = MainViewModel()
        navigationController.viewControllers = [mainViewController]
    }
    
    public func showGoogleMaps(previous: UIViewController, animated: Bool) {
        let mapViewController = MapViewController.instantiateFromStoryboardId(.GoogleMaps)
        let network = NetworkManager()
        let location = LocationManager()
        mapViewController.viewModel = MapViewModel(netwrok: network, location: location)
        navigationMove(from: previous, to: mapViewController, withTransition: .push, with: animated)
    }
    
    public func showNoLocationViewController(previous: UIViewController, with animation: Bool) {
        let nolocationViewController = NoLocationViewController.instantiateFromStoryboardId(.NoLocation)
        nolocationViewController.viewModel = NoLocationViewModel()
       navigationMove(from: previous, to: nolocationViewController, withTransition: .present, with: animation)
    }
    
    public func dismiss(with animation: Bool, complition: (()->())? = nil) {
        navigationController.presentedViewController?.dismiss(animated: animation, completion: complition)
    }
    
    public func dismiss(current controller: UIViewController, with animation: Bool, complition: (()-> ())? = nil) {
        controller.dismiss(animated: animation, completion: complition)
    }
    
    private func navigationMove(from: UIViewController, to: UIViewController, withTransition: TransitionType, complition: (()->())? = nil, with animation:Bool) {
        switch withTransition {
        case .push:
            from.navigationController?.pushViewController(to, animated: animation)
        case .pop:
            from.navigationController?.popViewController(animated: animation)
        case .present:
            from.navigationController?.present(to, animated: animation, completion: complition)
        case .popToRoot:
            from.navigationController?.popToViewController(to, animated: animation)
        }
    }
}
