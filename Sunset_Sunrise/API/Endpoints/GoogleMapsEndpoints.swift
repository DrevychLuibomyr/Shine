//
//  GoogleMapsEndpoints.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 9/30/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

enum GoogleMapsEndponts: Endpoint {
    
    case getSunInfo
    
    var server: Server {
        return .development
    }
    
    var methods: HTTPMethod {
        switch self {
        case .getSunInfo:
          return .GET
        }
    }
}
