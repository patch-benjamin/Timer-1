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
    private var isOn: Bool {
        if seconds > 0 {
            // TODO: Maybe change this logic??
            return true
        } else {
            return false
        }
    }
    
    func setTime(seconds: NSTimeInterval, totalSeconds: NSTimeInterval){
        self.seconds = seconds
        self.totalSeconds = totalSeconds
        startTimer()
    }
    
    func startTimer(){
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick", userInfo: nil, repeats: true)
            
        } else {}
    }
    
    func stopTimer() {
        timer = nil
    }
    
    func secondTick() {
        if timer != nil {
            seconds--
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(Timer.TimerSecondTickNotification, object: self)
            
            if seconds <= 0 {
                nc.postNotificationName(Timer.TimerCompleteNotification, object: self)
                stopTimer()
            }
        }
    }
    
    func timerString() -> String{
        let totalSeconds: Int = Int(self.seconds)
        let hour: Int
        let minute: Int
        let second: Int

        if totalSeconds/60 >= 60 { // hour or more
            hour = (totalSeconds/60/60)%60
            minute = (totalSeconds/60)%60
            second = totalSeconds%60
        } else if seconds/60 > 1 { // minute or more
            hour = 0
            minute = (totalSeconds/60)%60
            second = totalSeconds%60
            
        } else { // less than a minute
            hour = 0
            minute = 0
            second = totalSeconds%60
            
        }
        
        return "\(hour) : \(minute) : \(second)"

    }
}
