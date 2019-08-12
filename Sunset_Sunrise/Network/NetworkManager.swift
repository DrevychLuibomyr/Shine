//
//  NetworkManager.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func send(request: RequestCreatable, latitude: CLLocationDegrees, longitute: CLLocationDegrees, complition: @escaping ((NetworkResult) -> Void))
}

enum NetworkResult {
    case success(data: SunriseSunset, headers: [String:String])
    case failure(error: NetworkError)
}

final class NetworkManager {
    
    private let session: URLSession
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    init(timeout: TimeInterval = 15.second) {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeout
        sessionConfiguration.timeoutIntervalForResource = timeout
        session = URLSession(configuration: sessionConfiguration)
    }
}

//MARK: NetworkServiceProtocol
extension NetworkManager: NetworkServiceProtocol {
    func send(request: RequestCreatable, latitude: CLLocationDegrees, longitute: CLLocationDegrees, complition: @escaping ((NetworkResult) -> Void)) {
        
        guard let urlRequest = try? request.asURLRequest(long: "\(longitute)", lat: "\(latitude)") else {
            complition(.failure(error: .emptyRequest))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                complition(.failure(error: .generalFailure))
                return
            }
            
            switch response.statusCode {
            case 200...201:
                guard let data = data else {
                    complition(.failure(error: .serializationError))
                    return
                }
                
                guard let models = try? self.decoder.decode(SunriseSunset.self, from: data) else {
                    complition(.failure(error: .couldNotParseJSON(info: "Check SunsetSunrise Model")))
                    return
                }
                
                let headers: [String : String] = (response.allHeaderFields as? [String : String] ?? [:])
                DispatchQueue.main.async {
                    complition(.success(data: models, headers: headers))
                }
            case 400...404:
                DispatchQueue.main.async {
                    complition(.failure(error: .requestFailed(statusCode: response.statusCode)))
                }
            default:
                DispatchQueue.main.async {
                    complition(.failure(error: .requestFailed(statusCode: response.statusCode)))
                }
            }
        }
        task.resume()
    }
}
