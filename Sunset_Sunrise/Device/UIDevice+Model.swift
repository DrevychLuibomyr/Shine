//
//  UIDevice+Model.swift
//  MessageUI-Zip
//
//  Created by Luybckyk Drevych on 6/21/19.
//  Copyright © 2019 Luybckyk Drevych. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var modelIdentifier: String {
        let systemInfo = utsname()
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value))) }
        
    }
    
    var modelName: String {
        let identifier = modelIdentifier
        guard let url = Bundle.main.url(forResource: "Devices", withExtension: "plist"), let devices = NSDictionary(contentsOf: url) as? [String : Any] else {
            return identifier
        }
        
        guard let modelName = devices[identifier] as? String else {
            return identifier
        }
        return modelName
    }
}
