//
//  UIStoryboard+StoryboardInitializing.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

enum StoryboardId: String {
    case Main
    case UserScenario
    case GoogleMaps
    case NoLocation
}

protocol StoryboardInitializing {}

extension UIViewController: StoryboardInitializing {}

//MARK: UiViewController+ClassName
extension UIViewController {
    
    static func className() -> String {
        return String(describing: self)
    }
}

//MARK: StoryboardInitializing+InstantiateFromStoryboardId
extension StoryboardInitializing where Self: UIViewController {
    static func instantiateFromStoryboardId(_ storyboardId: StoryboardId) -> Self {
        let vcIdentifier = self.className()
        
        let storyboard = UIStoryboard(name: storyboardId.rawValue, bundle: nil) as UIStoryboard?
        assert(storyboard != nil, "Storyboard name is incorrect")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: vcIdentifier)
        assert(vc != nil, "ViewController id name is incorrect")
        
        return vc as! Self
    }
}
