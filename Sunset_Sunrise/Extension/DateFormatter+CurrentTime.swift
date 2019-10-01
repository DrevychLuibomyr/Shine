//
//  DateFormatter+CurrentTime.swift
//  Sunset_Sunrise
//
//  Created by Luybckyk Drevych on 10/1/19.
//  Copyright © 2019 liubomyr.drevych. All rights reserved.
//

import Foundation

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
