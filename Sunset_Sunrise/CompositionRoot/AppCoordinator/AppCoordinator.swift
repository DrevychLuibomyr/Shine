//
//  AppCoordinator.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/13/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

final class ApplicationCoordinator: Coordinator {
    
    //MARK: - Properties
    let window: UIWindow
    
    //MARK: - Constructor
    init(with window: UIWindow, router: RouterType, dependencies: Container) {
        self.window = window
        super.init(router: router, dependencies: dependencies)
    }
    
    //MARK: - Public Methods
    public func start() {
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
        let input = MainInput(with: self)
        let vc = dependencies.makeMainViewController(with: input)
        router.push(vc, animation: true)
    }
    
}

//MARK: - UINavigationControllerDelegate
extension ApplicationCoordinator: UINavigationControllerDelegate  {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousController) else {
            return
        }
    }
}
