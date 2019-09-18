//
//  MapsService.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 9/30/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

struct MapsService {
    
    public func getData(lat: Double, long: Double, complition: @escaping ((NetworkResult) -> Void)) {
        let networkManager = NetworkManager()
        let endPoint = GoogleMapsEndponts.getSunInfo
        let request = CustomRequest(endpoint: endPoint, body: nil)
        networkManager.send(request: request, latitude: lat, longitute: long, complition: complition)
    }
    
}
