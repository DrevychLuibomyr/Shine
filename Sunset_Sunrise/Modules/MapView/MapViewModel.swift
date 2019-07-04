//
//  MapViewModel.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

final class MapViewModel: BaseViewModel {
    
    private var netwrokManager = NetworkManager()
    var locationManager = LocationManager()
    var currentUserLocation = CLLocation()
    var marker = GMSMarker()
    
    init(netwrok: NetworkManager, location: LocationManager) {
        self.netwrokManager = netwrok
        self.locationManager = location
    }
    
    //MARK: Public
    public func requestPermissionForLocation() {
        locationManager.permissionForLocation()
    }
    
    public func showAlertError(on viewController: UIViewController,
                               buttonTitle: String,
                               title: String, message: String,
                               buttonAction: @escaping () -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitle, style: .default) { action in
            buttonAction()
        }
        alertViewController.addAction(alertButton)
        viewController.present(alertViewController,animated: true, completion: nil)
    }
    
    public func getSunsetSunriseDataFromUserLocation(viewController: UIViewController,complition: @escaping ((Result) -> Void)) {
        locationManager.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let lattitude, let longitute):
                self?.netwrokManager.getRequest(latitude: lattitude, longitute: longitute, complition: complition)
            case .faild(let error):
                self?.showAlertError(on: viewController, buttonTitle: ApplicationConstants.buttonAlertTitle , title: error, message: ApplicationConstants.alertControllerMessage, buttonAction: {})
            }
        }
    }
    
    public func getSunsetSunriseData(latitude: CLLocationDegrees, longitute: CLLocationDegrees,complition: @escaping ((Result) -> Void)) {
        netwrokManager.getRequest(latitude: latitude, longitute: longitute, complition: complition)
    }
    
}
