//
//  MapInput.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/6/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

struct MapInput: ModuleInput {
    
    var parentCoordinator: CoordinatorType
    
    init(parent: CoordinatorType) {
        self.parentCoordinator = parent
    }
    
}
