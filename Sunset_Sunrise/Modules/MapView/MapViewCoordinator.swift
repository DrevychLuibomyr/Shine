//
//  MapViewCoordinator.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 9/18/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

protocol GoogleMapsCoordinatorType: class {
    func showNoLocationViewController()
}

final class GoogleMapsCoordinator: CoordinatorType {
    
    //MARK: - Properties
    var router: RouterType
    var dependencies: Container
    
    //MARK: - Constructor
    init(with router: RouterType, dependencies: Container) {
        self.router = router
        self.dependencies = dependencies
    }
}

//MARK - GoogleMapsCoordinatorType
extension GoogleMapsCoordinator: GoogleMapsCoordinatorType {
    func showNoLocationViewController() {
        let controller = dependencies.makeNoLocationViewController()
        router.push(controller, animation: true)
    }
}
