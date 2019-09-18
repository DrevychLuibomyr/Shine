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
    var presenter: GoogleMapsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestPermissionForLocation()
        addInfroViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Private 
    @IBAction func didTapSearchAdress(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    private func setupViewController() {
        setupGMSMapView()
        addInfroViewController()
        presenter.requestPermissionForLocation()
    }
    
    private func setupGMSMapView() {
        mapView.delegate = self
        mapView.camera = GMSCameraPosition.camera(withLatitude:49.840124, longitude: 24.028197, zoom: 11)
        mapView.isMyLocationEnabled = true
    }
    
    private func addInfroViewController() {
        let infoViewCont = InfoViewController()
        infoViewCont.viewModel = self.presenter
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
        array.removeAll()
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        mapView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
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
