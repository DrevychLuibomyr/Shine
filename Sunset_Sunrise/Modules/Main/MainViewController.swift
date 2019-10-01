//
//  MainViewController.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var googlePlaceScenarioButton: UIButton!
    @IBOutlet private weak var exitButton: UIButton!
    
    var presenter: MainViewPresenter!
    var coordinator: MainViewControllerCoordinator!
    
    //MARK: Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        exitButton.setTitle(ApplicationConstants.exit, for: .normal)
        googlePlaceScenarioButton.setTitle(ApplicationConstants.googleMaps, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Private
    private func showActionoSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let feedbackAction = UIAlertAction(title: "Send Mail", style: .default) { [unowned self] action in
            self.presenter.sendFeedback(self)
        }
        let aboutProjAction = UIAlertAction(title: "About Project", style: .default) { action in
            self.addProjectInfoView()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(feedbackAction)
        alert.addAction(aboutProjAction)
        alert.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = self.view.bounds
            alert.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        self.present(alert, animated: true)
        
    }
    
    private func addProjectInfoView() {
        let infoView = ProjectView()
        infoView.frame = CGRect(x: self.view.frame.width / 2,
                                y: self.view.frame.height / 2,
                                width: 0, height: 0)
        self.view.addSubview(infoView)
    }
    
    //MARK: - Actions
    @IBAction private func showGoogleMapsScenario(_ sender: UIButton) {
        coordinator.showMap()
    }
    
    @IBAction private func exitApplication(_ sender: UIButton) {
        presenter.exitFromApplication()
    }
    
    @IBAction private func didTapOnSettigs(_ sender: UIButton) {
        showActionoSheet()
    }
}
