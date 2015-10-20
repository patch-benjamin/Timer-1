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
    var isOn: Bool {
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
            // repeat is false so we can control the secondTick to stop after the
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondTick:", userInfo: nil, repeats: true)
            
        } else {}
    }
    
    func stopTimer() {
        timer = nil
        seconds = 0
        totalSeconds = 0
    }
    
    func secondTick(counter: NSTimer) {
        if timer != nil {
            seconds--
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(Timer.TimerSecondTickNotification, object: self) // Second Tick
            
            if seconds <= 0 {
                nc.postNotificationName(Timer.TimerCompleteNotification, object: self) // Completion
                // stop the scheduledtimer
                counter.invalidate()
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
        } else if seconds/60 >= 1 { // minute or more
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
    
    func progressBar() -> (seconds: Int, totalSeconds: Int) {
        return (Int(seconds), Int(totalSeconds))
    }
    
}
