//
//  TimerUtils.swift
//  Network
//
//  Created by Luybckyk Drevych on 7/29/19.
//  Copyright © 2019 Luybckyk Drevych. All rights reserved.
//
import Foundation

//MARK: Int+TimeInterval
extension Int {
    public var second: TimeInterval       { return Double(self) }
    public var seconds: TimeInterval      { return Double(self) }
    
    public var minute: TimeInterval       { return Double(self) * 60 }
    public var minutes: TimeInterval      { return Double(self) * 60 }
    
    public var hour: TimeInterval         { return Double(self) * 3600 }
    public var hours: TimeInterval        { return Double(self) * 3600 }
    
    public var day: TimeInterval          { return Double(self) * 3600 * 24 }
    public var days: TimeInterval         { return Double(self) * 3600 * 24 }
}

//MARK: Double+TimeInterval
extension Double {
    public var second: TimeInterval       { return self }
    public var seconds: TimeInterval      { return self }
    public var seconds: TimeInterval      { return self }

    
    public var minute: TimeInterval       { return self * 60 }
    public var minutes: TimeInterval      { return self * 60 }
    
    public var hour: TimeInterval         { return self * 3600 }
    public var hours: TimeInterval        { return self * 3600 }
    
    public var day: TimeInterval          { return self * 3600 * 24 }
    public var days: TimeInterval         { return self * 3600 * 24 }
}
