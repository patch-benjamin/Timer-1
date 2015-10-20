//
//  Alarm.swift
//  Timer
//
//  Created by Mike Gilroy on 20/10/2015.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Alarm: NSObject {

    static let kAlarmCompleteNotification = "alarmCompleteNotification"
    
    private(set) var alarmDate: NSDate?
    var isAlarmed: Bool {
        return true
    }
    
    private var localNotification: UILocalNotification?
    
    func arm(fireDate: NSDate) {
        // set alarmDate property
        // Schedule UILocalNotification
        // Set localNotification property
    }
    
    func cancel() {
        // cancel scheduled UILocalNotification (with kString)
        // clear value of alarmDate
    }
    
    static func alarmComplete() {
        // post alarm complete notification
    }
    
}
