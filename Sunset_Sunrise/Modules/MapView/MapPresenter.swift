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
    func didRecieve(_ error: String?)
    func didChangeStatus()
}

protocol GoogleMapsPresenterInterface: class {
    func getDataFromUserLocation()
    func getDataFromPin(_ lat: Double, long: Double)
    func createPin(_ long: Double, lat: Double, map: GMSMapView)
}

final class GoogleMapsPresenter {
    
    //MARK: - Private Properties
    private var service = MapsService()
    private weak var view: GoogleMapsView?
    
    //MARK: - Properties
    var locationManager = LocationManager()
    var marker = GMSMarker()
    
    //MARK: - Constructor
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
    
    func getDataFromUserLocation() {
        locationManager.getCurrentLocation { [weak self] (result) in
            switch result {
            case .success(let lattitude, let longitute):
                self?.service.getData(lat: lattitude, long: longitute, complition: { (model) in
                    switch model {
                    case .success(let data, _):
                        self?.view?.updateViews(with: data)
                        print(data)
                    case .failure(let error):
                        guard let strongSelf = self else { return }
                        strongSelf.view?.didRecieve(error.errorDescription)
                    }
                })
            case .faild(let error):
                self?.view?.didRecieve(error)
            }
        }
    }
    
    func getDataFromPin(_ lat: Double, long: Double) {
        service.getData(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .success(let data, _):
                self?.view?.updateViews(with: data)
            case .failure(let error):
                self?.view?.didRecieve(error.errorDescription)
            }
        }
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
            view?.didChangeStatus()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized")
        }
    }
}
