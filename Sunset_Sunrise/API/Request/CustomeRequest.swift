//
//  CustomeRequest.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/2/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

protocol ServerInterface {
    var scheme: ServerScheme { get }
    var development: String { get }
}

enum ServerScheme: String {
    case http
    case https
}

struct Server: ServerInterface {
    var scheme: ServerScheme
    var development: String
    
    private init(scheme: ServerScheme, development: String) {
        self.scheme = scheme
        self.development = development
    }
    
    private init (_ server: ServerInterface) {
        self.init(scheme: server.scheme,
                  development: server.development)
    }

}

struct DevelopmentServer: ServerInterface {
    var scheme: ServerScheme {
        return .https
    }
    
    var development: String {
        return "api.sunrise-sunset.org"
    }
    
}

//MARK: Server
extension Server {
    static var development: Server {
        return .init(DevelopmentServer())
    }
}

