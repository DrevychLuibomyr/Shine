//
//  Constants.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

struct ProjectInfoViewConstatns {
    static let exitButton = "Exit"
}

struct ApplicationConstants {
    static let googlePlaceApiKey = "AIzaSyB2WZnPPZKk93zvB1xmWt_iDVwXAy6ae4k"
    static let exit = "Exit"
    static let googleMaps = "Let's have fun"
    static let buttonAlertTitle = "Ok"
    static let alertControllerTitle = "Ooops.."
    static let networkAlertMessage = "Something goes wrong"
    static let alertControllerMessage = "Your location service is disabl or you denied location permission, please go to settings and turn it on to get sunset and sunrise from your curent location"
    static let sunset = "Sunset:"
    static let sunrise = "Sunrise:"
    static let twilightEndText = "Twilight end:"
    static let twilightBeginText = "Twilight begin:"
    static let errorMessage = "Your location service is disable, please go to settings and turn it on to see images"
    static let settingButton = "Settings"
    static let restrictedAlertTitle = "Check your lcoation services"
    static let restrictedAlertMessage = "Please check your preferences for using the app below"
    static let restrictedAlertButtonName = "Open Setting"
}

struct NetwrokConstatns {
    static let sunsetSunriseSchema = "https"
    static let sunsetSunriseHost = "api.sunrise-sunset.org"
    static let sunsetSunrisePath = "/json"
    static let longitute = "lng"
    static let latitude = "lat"
    static let date = "date"
    static let dateValue = "today"
}

struct MailManagerConstatns  {
    static let email = "LDrevych@gmail.com"
    static let subject = "Feedback From"
    static let body = """
Dear reviewer
Thank you, for paying attention for my work, a specially for review and for checking functionality.
I hope you like my work and I want to hear where I mess up and what I need to do, to make my projects better and in what area I must increase my knowledge. For all points please provide good/bad point’s about this task

List of moments during project creation
1. Architecture
2. Clean code
3. SOLID principles
4. Knowledge of language
5. Design
6. Personal opinion
7. CI Configuration
"""
    static let recipients = ""
}
