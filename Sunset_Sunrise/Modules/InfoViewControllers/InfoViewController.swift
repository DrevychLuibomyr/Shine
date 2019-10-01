    //
//  InfoViewController.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 4/2/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import UIKit
import CoreLocation

final class InfoViewController: UIViewController {
    
    @IBOutlet private weak var sunsetText: UILabel!
    @IBOutlet private weak var sunriseText: UILabel!
    @IBOutlet private weak var twilightEndText: UILabel!
    @IBOutlet private weak var twilightBeginText: UILabel!
    
    private let fullView: CGFloat = 100
    private var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    
    //MARK: Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInfoView()
    }
    
    //MARK: Public
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    //MARK - Private
    @IBAction func didTapOnGetDataFromUserLocation(_ sender: UIButton) {
        //self.fetchData(latitude: viewModel.currentUserLocation.coordinate.latitude, longitute: viewModel.currentUserLocation.coordinate.longitude)
    }
    
    @IBAction func didTapOnPinLocation(_ sender: UIButton) {
       // self.fetch(latitude: viewModel.marker.position.latitude, longitute: viewModel.marker.position.longitude)
    }
    
    private func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .regular)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    private func setupViewController() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(InfoViewController.panGesture))
        view.addGestureRecognizer(gesture)
    }
    
    private func showInfoView() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
        })
    }
}

//MARK: DateFormatter+GetLocalTime
extension DateFormatter {
    func getLocalTime(from time: String) -> String {
        self.dateFormat = "hh:mm:ss a"
        self.timeZone = NSTimeZone.local
        guard let date = self.date(from: time) else { return "" }
        let timeStamp = self.string(from: date)
        return timeStamp
    }
}
