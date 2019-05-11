//
//  Constants.swift
//  Sunset_Sunrise
//
//  Created by liubomyr.drevych on 3/29/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

struct ApplicationConstants {
    static let googlePlaceApiKey = "AIzaSyB2WZnPPZKk93zvB1xmWt_iDVwXAy6ae4k"
    static let welcomeWord = "Sincerely glad that you went to check the work done by me, I will look forward to answering my work and your impressions."
    static let exit = "Exit"
    static let googleMaps = "Let's have fun"
    static let buttonAlertTitle = "Ok"
    static let alertControllerTitle = "Ooops.."
    static let networkAlertMessage = "Something goes wrong"
    static let alertControllerMessage = "Your location service is disabl or you denied location permission, please go to settings and turn it on to get sunset and sunrise from your curent location"
    static let sunset = "Sunset:"
    static let sunrise = "Sunrise:"
    static let twilightEndText = "Twilight End Time:"
    static let twilightBeginText = "Twilight Begin Time:"
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


