//
//  ProjectView.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 9/30/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit

protocol ProjectViewDelegate: class {
    func didTapExit()
}

final class ProjectView: UIView {

    weak var delegate: ProjectViewDelegate?

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var quitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("ProjectViewInfo", owner: self, options: nil)
        quitButton.setTitle(ProjectInfoViewConstatns.exitButton, for: .normal)
    }
    
    @IBAction func exit(_ sender: UIButton) {
        self.delegate?.didTapExit()
    }
}
