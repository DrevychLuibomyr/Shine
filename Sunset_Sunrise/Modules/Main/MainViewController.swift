//
//  MainViewController.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var googlePlaceScenarioButton: UIButton!
    @IBOutlet private weak var exitButton: UIButton!
    
    var viewModel: MainViewModel!
    
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
    
    //MARK: Private
    @IBAction private func showGoogleMapsScenario(_ sender: UIButton) {
        viewModel.showGoogleMaps(viewController: self, animated: true)
    }
    
    @IBAction private func exitApplication(_ sender: UIButton) {
        viewModel.exitFromApplication()
    }
    
    @IBAction private func didTapOnSettigs(_ sender: UIButton) {
        
    }
    
}
