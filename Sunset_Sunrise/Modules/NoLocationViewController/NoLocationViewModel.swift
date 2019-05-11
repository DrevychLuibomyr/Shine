//
//  NoLocationViewModel.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 5/11/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation
import UIKit

final class NoLocationViewModel {
    
    //MARK: Public
    public func openSettings(owner: UIViewController) {
        self.showAlertError(on: owner, buttonTitle: ApplicationConstants.buttonAlertTitle, title: ApplicationConstants.alertControllerTitle, message: ApplicationConstants.alertControllerMessage) {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    //MARK: Private
    private func showAlertError(on viewController: UIViewController,
                               buttonTitle: String,
                               title: String, message: String,
                               buttonAction: @escaping () -> Void) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: buttonTitle, style: .default) { action in
            buttonAction()
        }
        alertViewController.addAction(alertButton)
        viewController.present(alertViewController,animated: true, completion: nil)
    }
    
}
