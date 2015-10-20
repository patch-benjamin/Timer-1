//
//  Alarm.swift
//  Timer
//
//  Created by Mike Gilroy on 20/10/2015.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    static let kAlarmCategoryName = "Alarm"
    static let kAlarmCompleteNotification = "alarmCompleteNotification"
    
    private(set) var alarmDate: NSDate?
    var isAlarmed: Bool {
        get {
            if alarmDate != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    private var localNotification: UILocalNotification?
    
    func arm(fireDate: NSDate) {
        alarmDate = fireDate
        
        // Schedule UILocalNotification
        localNotification = UILocalNotification()
        localNotification?.alertBody = "The time has finally come..."
        localNotification?.alertTitle = "Be alarmed!!"
        UIApplication.sharedApplication().applicationIconBadgeNumber += 1
        localNotification?.fireDate = alarmDate
        localNotification?.category = Alarm.kAlarmCategoryName
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification!)
        

    }
    
    func cancel() {
        // cancel scheduled UILocalNotification (with kString)
        UIApplication.sharedApplication().cancelLocalNotification(localNotification!)
        UIApplication.sharedApplication().applicationIconBadgeNumber -= 1
        
        
        // clear value of alarmDate
        alarmDate = nil
    }
    
    static func alarmComplete() {
        // post alarm complete notification
        NSNotificationCenter.defaultCenter().postNotificationName(Alarm.kAlarmCompleteNotification, object: self)
    }
    
    
    func getDateString() -> String {
        if let date = alarmDate {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .LongStyle
            dateFormatter.timeStyle = .ShortStyle
            return dateFormatter.stringFromDate(date)
//            dateFormatter.dateFormat = "MMMM dd, yyyy"
//            let dateString = dateFormatter.stringFromDate(date)
//            
//            dateFormatter.dateFormat = "hh:mm a"
//            let timeString = dateFormatter.stringFromDate(date)
//
//            return "\(dateString) at \(timeString)"
        } else {
            return ""
        }
    }
    
}
