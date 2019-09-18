//
//  UIViewController+AlertView.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 9/18/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

//MARK: - UIViewController+AlertController
extension UIViewController {
    
    public func showAlertController(_ buttonTitle: String, title: String, message: String, buttonAction: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: { action in
                buttonAction()
            })
            alertViewController.addAction(action)
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
}
