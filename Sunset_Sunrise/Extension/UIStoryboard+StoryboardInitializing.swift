//
//  UIStoryboard+StoryboardInitializing.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

//MARK: UIStoryboard+InstantiateViewController
extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(withType type: T.Type) -> T {
        let identifier = String(describing: T.self)
        guard let instantiateViewController = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Error with founding \(T.self)")
        }
        return instantiateViewController
    }
}

//MARK: UIStoryboard+Names
extension UIStoryboard {
    
    private enum Names {
        static let main = UIStoryboard(name: "Main", bundle: nil)
        static let google = UIStoryboard(name: "GoogleMaps", bundle: nil)
        static let noLocation = UIStoryboard(name: "NoLocation", bundle: nil)
    }
    
    enum Main {
        static var mainVC: MainViewController {
            return Names.main.instantiateViewController(withType: MainViewController.self)
        }
    }
    
    enum GoogleMaps {
        static var googleMapsVC: MapViewController {
            return Names.google.instantiateViewController(withType: MapViewController.self)
        }
    }
    
    enum NoLocation {
        static var noLocationVC: NoLocationViewController {
            return Names.noLocation.instantiateViewController(withType: NoLocationViewController.self)
        }
    }
}
