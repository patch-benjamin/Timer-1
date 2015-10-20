//
//  Timer.swift
//  Timer
//
//  Created by Benjamin Patch on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class Timer: NSObject {

    // KEYS
    static let TimerSecondTickNotification: String = "timerSecondTickNotification"
    static let TimerCompleteNotification: String = "timerCompleteNotification"
    
    // Variables
    private(set) var seconds = NSTimeInterval(0)
    private(set) var totalSeconds = NSTimeInterval(0)
    private var timer: NSTimer?
    private var localNotification: UILocalNotification?
    
    
    var isOn: Bool {
        if timer == nil  {
            // TODO: Maybe change this logic??
            return false
        } else {
            return true
        }
    }

    var isStarted: Bool {
        if timer == nil  && seconds <= 0 {
            // TODO: Maybe change this logic??
            return false
        } else {
            return true
        }
    }

    
    func setTime(seconds: NSTimeInterval, totalSeconds: NSTimeInterval){
        self.seconds = seconds
        self.totalSeconds = totalSeconds
        startTimer()
    }
    
    func startTimer(){
        if timer == nil {
            // repeat is false so we can control the secondTick to stop after the
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
            
            let localNotification = UILocalNotification()
            localNotification.alertTitle = "Timer complete"
            localNotification.alertBody = "You've run out of time!"
            localNotification.applicationIconBadgeNumber = 1
            localNotification.fireDate = NSDate().dateByAddingTimeInterval(seconds)
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
        } else {}
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        seconds = 0
        totalSeconds = 0
        if let notif = localNotification {
            UIApplication.sharedApplication().cancelLocalNotification(notif)
        }

    }
    
    func secondTick() {
        seconds--
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName(Timer.TimerSecondTickNotification, object: self) // Second Tick
        
        if seconds <= 0 {
            nc.postNotificationName(Timer.TimerCompleteNotification, object: self) // Completion
            stopTimer()
        }
    }
    
    func timerString() -> String{
        let totalSeconds: Int = Int(self.seconds)
        let hour = totalSeconds / 60 / 60
        let minute = (totalSeconds / 60) % 60
        let second = totalSeconds % 60

        var answer: String = "\(hour) : "
        
        if minute < 10 {
            answer += "0\(minute) : "
        } else {
            answer += "\(minute) : "
        }
        
        if second < 10 {
            answer += "0\(second)"
        } else {
            answer += "\(second)"
        }
        return answer
//        if minute < 10 && second < 10 {
//            return "\(hour):0\(minute):0\(second)"
//        } else if minute < 10 {
//            return "\(hour):0\(minute):\(second)"
//        } else {
//            return "\(hour):0\(minute):\(second)"
//        }
    }
    
    func progressBar() -> (seconds: Int, totalSeconds: Int) {
        return (Int(seconds), Int(totalSeconds))
    }
    
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        
        if let notif = localNotification {
            UIApplication.sharedApplication().cancelLocalNotification(notif)
        }
    
    }
    
}
