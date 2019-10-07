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
    
    //MARK: - IBOutlet
    @IBOutlet private weak var mapView: GMSMapView!
    
    //MARK: - Private Properties
    private var pinArray = [GMSMarker]()
    
    //MARK: - Properties
    var presenter: GoogleMapsPresenter!
 
    //MARK: - ViewController life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getDataFromUserLocation()
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
        presenter.requestPermissionForLocation()
        setupGMSMapView()
        addInfroViewController()
    }
    
    private func setupGMSMapView() {
        mapView.delegate = self
        mapView.camera = GMSCameraPosition.camera(withLatitude: 49.840124, longitude: 24.028197, zoom: 11)
        mapView.isMyLocationEnabled = true
    }
    
    private func addInfroViewController() {
        let infoViewCont = InfoViewController()
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
        pinArray.removeAll()
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        mapView.camera = camera
        self.dismiss(animated: true, completion: nil)
        presenter.createPin(place.coordinate.longitude, lat: place.coordinate.latitude, map: mapView)
    }
    
    final func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(" ERROR AUTO COMPLETE \(error)")
    }
    
    final func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
}

//MARK: GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print(" Marker did start dragging")
    }
    
    final func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print(" Marker did stop dragging")
        let markerModel = PinModel(latitude: marker.position.latitude, longitude: marker.position.longitude)
        print(" long: \(markerModel.longitude), lat: \(markerModel.latitude)")
    }
}

