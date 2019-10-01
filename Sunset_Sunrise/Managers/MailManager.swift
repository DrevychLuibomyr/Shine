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
    
    //MARK: - Properties
    private let picker = MFMailComposeViewController()
    
    //MARK: - Constructor
    override init() {
        super.init()
        picker.delegate = self
    }
    
    //MARK: - Methods
    public func sendMessage(in controller: UIViewController) {
        guard MFMailComposeViewController.canSendMail() else {
            showAlert(on: controller, title: "Oppss......", message: "Smth goes wrong", complition: { })
            return
        }
        picker.setSubject(MailManagerConstatns.subject)
        picker.setToRecipients([MailManagerConstatns.email])
        picker.setToRecipients([MailManagerConstatns.recipients])
        picker.setMessageBody(MailManagerConstatns.body, isHTML: false)
        
        controller.present(picker, animated: true, completion: nil)
    }
    
    private func showAlert(on controller: UIViewController, title: String, message: String, complition: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            complition()
        }
        alertController.addAction(action)
        controller.present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: - MFMailComposeViewControllerDelegate
extension MailManager: MFMailComposeViewControllerDelegate {
    final func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
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


//MARK: UINavigationControllerDelegate
extension MailManager: UINavigationControllerDelegate { }
