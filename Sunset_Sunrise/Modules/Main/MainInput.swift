//
//  MainInput.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/5/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

struct MainInput: ModuleInput {
    
    var parentCoordinator: CoordinatorType
    
    init(with parent: CoordinatorType) {
        self.parentCoordinator = parent
    }
    
}
