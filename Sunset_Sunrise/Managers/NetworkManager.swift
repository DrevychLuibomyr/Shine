//
//  NetworkManager.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

enum NetwrokError {
    case wrongURL
    case serializationError
    case parseJSON
}

enum Result {
    case success(data: SunriseSunset)
    case failure(error: NetwrokError)
}

final class NetworkManager {
    
    //MARK: Public
    func getRequest(latitude: CLLocationDegrees, longitute: CLLocationDegrees, complition: @escaping ((Result) -> Void)) {
        guard let url = getSunsetSunriseURL(long: "\(longitute)", lat: "\(latitude)") else {
            complition(.failure(error: .wrongURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 60
        Alamofire.request(urlRequest).responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            guard let jsonData = response.data  else {
                complition(.failure(error: .serializationError))
                return
            }
            let decoder = JSONDecoder()
            guard let models = try? decoder.decode(SunriseSunset.self, from: jsonData) else {   //Decode JSON Response Data
                complition(.failure(error: .parseJSON))
                return
            }
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString as Any)
            complition(.success(data: models))
        }
        
    }
    
    //MARK: Private 
    private func getSunsetSunriseURL(long: String, lat: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetwrokConstatns.sunsetSunriseSchema
        urlComponents.host = NetwrokConstatns.sunsetSunriseHost
        urlComponents.path = NetwrokConstatns.sunsetSunrisePath
        urlComponents.queryItems = [
            URLQueryItem(name: NetwrokConstatns.latitude, value: lat),
            URLQueryItem(name: NetwrokConstatns.longitute, value: long),
            URLQueryItem(name: NetwrokConstatns.date, value: NetwrokConstatns.dateValue)
        ]
        return urlComponents.url
    }
}

