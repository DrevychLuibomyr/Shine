//
//  MailManager.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 8/14/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import MessageUI

final class MailManager: NSObject {
    
}

extension MailManager: MFMailComposeViewControllerDelegate {
   
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Cancelled")
        case .sent:
            print("Sended")
        case .failed:
            guard let error = error else { return }
            print(error.localizedDescription)
        case .saved:
            print("Message Saved")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

