//
//  RequestCreatable.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/3/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

typealias Endpoint = RequestConstructable & URLConstructable

protocol RequestCreatable: AnyObject {
    var endpoint: Endpoint { get set }
    var body: Encodable? { get set }
    func asURLRequest(long: String, lat: String) throws -> URLRequest
    func addStandartHeadersFor(request: inout URLRequest)
}

protocol RequestConstructable {
    var methods: HTTPMethod { get }
}

final class CustomRequest: RequestCreatable {
    
    var endpoint: Endpoint
    var body: Encodable?
    
    init(endpoint: Endpoint, body: Encodable? = nil) {
        self.endpoint = endpoint
        self.body = body
    }
}

extension RequestCreatable {
    
    func addStandartHeadersFor(request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "content-type")
    }
    
    func asURLRequest(long: String, lat: String) throws -> URLRequest {
        guard let destinationURL = try? endpoint.asURL(long: long, lat: lat) else {
            throw NetworkError.cannotCreateRequest
        }
        
        var urlRequest = URLRequest(url: destinationURL)
        urlRequest.httpMethod = endpoint.methods.rawValue
        addStandartHeadersFor(request: &urlRequest)
        urlRequest.timeoutInterval = 15.second
        
        return urlRequest
    }
}
