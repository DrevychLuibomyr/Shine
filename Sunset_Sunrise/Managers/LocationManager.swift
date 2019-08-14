//
//  LocationManage.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationResult {
    case success(lattitude: CLLocationDegrees, longitute: CLLocationDegrees)
    case faild(error: String)
}

enum PermissionState: String {
    case notDetermined
    case authorized
    case denied
    case restricted
}

protocol LocationManagerDelegate: class {
    func didChange(status: CLAuthorizationStatus)
}

protocol LocationServiceProtocol {
    func getCurrentLocation(completion: @escaping LocationResultHandler)
    func permissionForLocation()
}

typealias LocationResultHandler = (LocationResult) -> ()

final class LocationManager: NSObject {
   
    //MARK: - Properties
    private let locationManager = CLLocationManager()
    fileprivate var locationHandlers: [LocationResultHandler] = []
    
    public var status = CLLocationManager.authorizationStatus()    
    weak var delegate: LocationManagerDelegate?
    
    //MARK: - Constructor
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
}

//MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
   final func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        let lat = newLocation.coordinate.latitude
        let long = newLocation.coordinate.longitude
        locationHandlers.forEach {
            $0(.success(lattitude: lat, longitute: long))
        }
        locationHandlers.removeAll()
    }
    
   final func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationHandlers.forEach {
            $0(.faild(error: error.localizedDescription))
        }
        locationHandlers.removeAll()
    }
    
    final func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.delegate?.didChange(status: status)
    }
}

//MARK: LocationServiceProtocol
extension LocationManager: LocationServiceProtocol {
    public func permissionForLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print(PermissionState.restricted.rawValue)
        case .denied:
            print(PermissionState.denied.rawValue)
        case .authorizedAlways,.authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print(PermissionState.authorized.rawValue)
        }
    }
    
    public func getCurrentLocation(completion: @escaping LocationResultHandler) {
        locationHandlers.append(completion)
        locationManager.requestLocation()
    }
}
