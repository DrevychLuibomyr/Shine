//
//  MapViewModel.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import GoogleMaps
import Foundation

protocol GoogleMapsView: class {
    func updateViews(with model: SunriseSunset)
}

protocol GoogleMapsPresenterInterface: class {
    func getDataFromUserLocation(complition: @escaping ((NetworkResult) -> Void))
    func getDataFromPin(_ lat: Double, long: Double, complition: @escaping ((NetworkResult) -> Void))
    func createPin(_ long: Double, lat: Double, map: GMSMapView)
}

final class GoogleMapsPresenter {
    
    private var netwrokManager = NetworkManager()
    private weak var view: GoogleMapsView?
    var locationManager = LocationManager()
    var marker = GMSMarker()
    
    init(location: LocationManager) {
        self.locationManager = location
        locationManager.delegate = self
    }
    
    //MARK: Public
    public func requestPermissionForLocation() {
        locationManager.permissionForLocation()
    }
}

//MARK: - GoogleMapsPresenterInterface
extension GoogleMapsPresenter: GoogleMapsPresenterInterface {
    func getDataFromUserLocation(complition: @escaping ((NetworkResult) -> Void)) {
        print()
    }
    
    func getDataFromPin(_ lat: Double, long: Double, complition: @escaping ((NetworkResult) -> Void)) {
        
    }
    
    func createPin(_ long: Double, lat: Double, map: GMSMapView) {
        let marker = GMSMarker()
        marker.isDraggable = true
        let position = PinModel(latitude: lat, longitude: long)
        marker.position = CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude)
        DispatchQueue.main.async {
            marker.map = map
        }
    }
}

//MARK: - LocationManagerDelegate
extension GoogleMapsPresenter: LocationManagerDelegate {
    func didChange(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not determind")
        case .restricted, .denied:
            print("Fuck")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized")
        }
    }
}
