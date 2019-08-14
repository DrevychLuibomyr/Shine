//
//  ApplicationCoordinator.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/4/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorType {
    var router: RouterType { get }
    var dependencies: DependencyContainer { get }
}

open class Coordinator: NSObject, CoordinatorType {
    
    public var childCoordinator: [Coordinator] = []
    
    public var router: RouterType
    var dependencies: DependencyContainer
    
    init(router: RouterType, dependencies: DependencyContainer) {
        self.router = router
        self.dependencies = dependencies
        super.init()
    }
    
    public func addChild(_ coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    public func removeChild(_ coordinator: Coordinator?) {
        if let coordinator = coordinator, let index = childCoordinator.firstIndex(of: coordinator) {
            childCoordinator.remove(at: index)
        }
    }
}
