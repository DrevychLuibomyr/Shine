//
//  Router.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/4/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

public protocol RouterType: AnyObject {
    var navigationController: UINavigationController { get }
    func push(_ vc: UIViewController, animation: Bool)
    func pop(_ animation: Bool)
    func popToViewController(_ vc: UIViewController, animated: Bool)
    func popToRootViewController(_ animated: Bool)
    func dismiss(_ animated: Bool, complition: (() -> Void)?)
}

final class Router: RouterType {
    
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func push(_ vc: UIViewController, animation: Bool) {
        navigationController.pushViewController(vc, animated: animation)
    }
    
    public func pop(_ animation: Bool) {
        navigationController.popViewController(animated: animation)
    }
    
    public func popToRootViewController(_ animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    public func popToViewController(_ vc: UIViewController, animated: Bool) {
        navigationController.popToViewController(vc, animated: animated)
    }
    
    public func dismiss(_ animated: Bool, complition: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: complition)
    }
    
}
