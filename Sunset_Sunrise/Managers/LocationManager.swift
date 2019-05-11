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

typealias LocationResultHandler = (LocationResult) -> ()

final class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    public var status = CLLocationManager.authorizationStatus()
    fileprivate var locationHandlers: [LocationResultHandler] = []
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
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
