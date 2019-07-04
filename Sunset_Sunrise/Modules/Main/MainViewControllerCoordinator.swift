//
//  MainViewControllerCoordinator.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/4/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

protocol MainViewControllerCoordinatorType {
    func showMap()
}

final class MainViewControllerCoordinator: CoordinatorType {
    var router: RouterType
    var dependencies: DependencyContainer
    
    init(with router: RouterType, dependencies: DependencyContainer) {
        self.router = router
        self.dependencies = dependencies
    }
    
}

//MARK: MainViewControllerCoordinatorType
extension MainViewControllerCoordinator: MainViewControllerCoordinatorType {
    func showMap() {
        let vc = dependencies.makeGoogleMapsViewController()
        router.push(vc, animation: true)
    }
}
