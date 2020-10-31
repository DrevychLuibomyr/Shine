//
//  URLConstructable.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/3/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

protocol URLConstructable {
    var server: Server { get }
    func asURL(long: String, lat: String) throws -> URL
}

extension URLConstructable {
    
    func asURL(long: String, lat: String) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = server.scheme.rawValue
        urlComponents.host = server.development
        urlComponents.path = NetwrokConstatns.sunsetSunrisePath
        urlComponents.queryItems = [
            URLQueryItem(name: NetwrokConstatns.latitude, value: lat),
            URLQueryItem(name: NetwrokConstatns.longitute, value: long),
            URLQueryItem(name: NetwrokConstatns.date, value: NetwrokConstatns.dateValue)
        ]
        
        guard let finalURL = urlComponents.url else {
            throw NetworkError.wrongURL(info: "Smth wrong with url, please check this out")
        }
        
        return finalURL
    }
    
}
