//
//  MainViewModel.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import Foundation

protocol MainViewPresenterInterface: class {
    func exitFromApplication()
    func sendFeedback(_ controller: UIViewController)
}

final class MainViewPresenter {
    
    //MARK: - Properties
    private var mailManager = MailManager()
    
    //MARK: Constructor
    init(manager: MailManager) {
        self.mailManager = manager
    }
}

//MARK: - MainViewPresenterInterface
extension MainViewPresenter: MainViewPresenterInterface {
    func sendFeedback(_ controller: UIViewController) {
        mailManager.sendMessage(in: controller)
    }
    
    func exitFromApplication() {
        let application = UIApplication.shared
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: application, for: nil)
        Thread.sleep(forTimeInterval: 0.5)
        exit(0)
    }
}
