//
//  LogManager.swift
//  Sunset_Sunrise
//
//  Created by binariksuser1111 on 7/3/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

final class MailManager: NSObject {
    
    private var viewController = UIViewController()
    
    init(controller: UIViewController) {
        super.init()
        self.viewController = controller
    }
    
    public func sendMail(from: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setSubject("Feedback Form")
            mail.delegate = self
            mail.mailComposeDelegate = self
            mail.setMessageBody(self.deviceInfo(), isHTML: false)
        } else {
            print(":(")
        }
    }
    
    
    private func deviceInfo() -> String {
        let device = UIDevice.current
        let appVersion = "Version " + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!
        
        var info = "Device info\n"
        info += "Name: \(device.name)\n"
        info += "System Name: \(device.systemName)\n"
        info += "System Version: \(device.systemVersion)\n"
        info += "Model Name: \(device.modelName)"
        info += "App Version: \(appVersion)\n"
        if let buildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as? String {
            info += "Build Number: \(buildNumber)\n"
        }
        info += "Localized Model: \(device.localizedModel)\n"
        info += "Identifier For Vendor: \((device.identifierForVendor?.uuidString)!)\n"
        info += "Mult tasking support: \(device.isMultitaskingSupported.description)\n"
        
        return info
    }
    
}

//MARK:
extension MailManager: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail was saved")
        case .sent:
            print("Sended")
        case .failed:
            print("Fail - \(error?.localizedDescription ?? "")")
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: UINavigationControllerDelegate
extension MailManager: UINavigationControllerDelegate { }
