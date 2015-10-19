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
    }
    
    func startTimer(){
        if timer == nil {
            timer = NSTimer(fireDate: NSDate(), interval: totalSeconds, target: self, selector: "secondTick:", userInfo: nil, repeats: true)
            
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
        if seconds/60 >= 60 {
            return "\(seconds/60/60) : \((seconds/60)%60) : \(((seconds/60)/60)%60)"
        } else {
            return "0 :\(seconds/60) : \(seconds%60)"
        }
    }
}
