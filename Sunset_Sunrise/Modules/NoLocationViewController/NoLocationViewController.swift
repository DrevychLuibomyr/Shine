//
//  NoLocationViewController.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 5/11/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

class NoLocationViewController: UIViewController {

    var viewModel: NoLocationViewModel!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle(ApplicationConstants.settingButton, for: .normal)
    }

    @IBAction func showAlert(_ sender: UIButton) {
        viewModel.openSettings(owner: self)
    }
    
}
