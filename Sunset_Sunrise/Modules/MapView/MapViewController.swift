//
//  MapViewController.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

final class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: GMSMapView!
    
    private var array = [GMSMarker]()
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel.locationManager.delegate = self
        self.mapView.camera = GMSCameraPosition.camera(withLatitude:49.840124, longitude: 24.028197, zoom: 11)
        self.mapView.isMyLocationEnabled = true
        addInfroViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Private 
    @IBAction func didTapSearchAdress(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    private func createPin(for longitute: CLLocationDegrees, latitude: CLLocationDegrees, marker: GMSMarker) {
        DispatchQueue.main.async { [weak self] in
            self?.array.append(marker)
            marker.isDraggable = true
            let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitute)
            marker.position = position
            marker.map = self?.mapView
            self?.viewModel.marker = marker
        }
    }
    
    private func addInfroViewController() {
        let infoViewCont = InfoViewController()
        infoViewCont.viewModel = self.viewModel
        self.addChild(infoViewCont)
        self.view.addSubview(infoViewCont.view)
        infoViewCont.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        infoViewCont.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
}

//MARK: GMSAutocompleteViewControllerDelegate
extension MapViewController: GMSAutocompleteViewControllerDelegate {
    
    final func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.array.removeAll()
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
        self.createPin(for: place.coordinate.longitude, latitude: place.coordinate.latitude, marker: self.viewModel.marker)
    }
    
    final func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    final func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
}

//MARK: GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    final func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("\(marker) change his position")
        print("New position in equal's \(marker.position.latitude) + \(marker.position.longitude)")
    }
    
}

//MARK: LocaitonManagerDelegate
extension MapViewController: LocationManagerDelegate {
    
    final func didChange(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not determined")
        case .restricted, .denied:
            print("")
           // viewModel.showNoLocationViewController(current: self, animated: true)
        case .authorizedWhenInUse, .authorizedAlways:
            print("")
            //viewModel.dismissNoLocationViewController()
        }
    }
    
}
