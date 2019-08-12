//
//  MainViewModel.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

final class MainViewModel {
    
    func exitFromApplication() {
        let application = UIApplication.shared
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: application, for: nil)
        Thread.sleep(forTimeInterval: 0.5)
        exit(0)
    }
    
}
