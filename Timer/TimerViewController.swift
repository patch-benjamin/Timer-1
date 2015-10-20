//
//  TimerViewController.swift
//  Timer
//
//  Created by Benjamin Patch on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    // MARK: Properties
    var isPaused: Bool = false
    let timer = Timer()
    // MARK: Outlets
    
    // First View:
    @IBOutlet weak var hourPicker: UIPickerView!
    
    @IBOutlet weak var minutePicker: UIPickerView!
    
    @IBOutlet weak var pickerStackView: UIStackView!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var startCancelButton: UIButton!
    
    // Second View
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    
    
    
    // MARK: Actions
    
    @IBAction func startTouched(sender: UIButton) {
        if startCancelButton.titleLabel?.text == "Start" && validTimeEntry(){
            setTimer()
            timeLabelUpdate()
            labelOnView()
        } else {
            labelOffView()
            pauseButton.setTitle("Pause", forState: .Normal)
            isPaused = !isPaused
        }
    }
    
    @IBAction func pauseTouched(sender: UIButton) {
        
        if timer.isStarted {
            if isPaused{ // play it and show option to "pause"
                
                pauseButton.setTitle("Pause", forState: .Normal)
                timer.startTimer()
                
            } else { // pause it and show option to "play"
                
                pauseButton.setTitle("Play", forState: .Normal)
                timer.pauseTimer()
                
                
            }
            isPaused = !isPaused
        }
        
    }
    
    func validTimeEntry() -> Bool{
        let hour = hourPicker.selectedRowInComponent(0)
        let minute = minutePicker.selectedRowInComponent(0)
        if minute == 0 && hour == 0 {
            
            return false
        } else {
            return true
        }
    }
    
    func setTimer(){
        // get values at hourpicker and minute picker
        let hour = hourPicker.selectedRowInComponent(0)
        let minute = minutePicker.selectedRowInComponent(0)
        let seconds = ((hour*60)*60) + (minute*60)
        //convert it to seconds
        // call timer.setTime with the seconds
        timer.setTime(NSTimeInterval(seconds), totalSeconds: NSTimeInterval(seconds))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCancelButton.layer.borderColor = UIColor.buttonTextColor().CGColor
        startCancelButton.layer.borderWidth = 3
        
        pauseButton.layer.borderColor = UIColor.buttonTextColor().CGColor
        pauseButton.layer.borderWidth = 3
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "timeLabelUpdate", name: Timer.TimerSecondTickNotification, object: nil)
        nc.addObserver(self, selector: "timerComplete", name: Timer.TimerCompleteNotification, object: nil)
    }
    
    func timeLabelUpdate() {
        timerLabel.text = timer.timerString()
        // Set progress bar too
        let secondInfo = timer.progressBar()
        if secondInfo.seconds > 0{
            let seconds: Float = Float(secondInfo.seconds)
            let totalSecs: Float = Float(secondInfo.totalSeconds)
            let progress: Float = seconds/totalSecs
            print ("\(seconds) : \(totalSecs)")
            // Control animation/sliding effect of progress bar
            if seconds == totalSecs{
                progressBar.setProgress(progress, animated: false)
            } else {
                progressBar.setProgress(progress, animated: true)
            }
     
        }
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func labelOffView(){
        // turn off label and progressbar
        progressBar.hidden = true
        timerLabel.hidden = true
        
        //turn on view with selectors
        pickerStackView.hidden = false
        
        // set button to "start"
        startCancelButton.setTitle("Start", forState: .Normal)
        
        // cancel timer
         timer.stopTimer()
    }

    func labelOnView(){
        // turn on label and progressbar
        progressBar.hidden = false
        timerLabel.hidden = false
        
        //turn off view with selectors
        pickerStackView.hidden = true
        
        // set button to "cancel"
        startCancelButton.setTitle("Cancel", forState: .Normal)
    }

    func timerComplete() {
        labelOffView()

        let alert = UIAlertController(title: "Timer Complete", message: "You've run out of time!", preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK", style: .Default) { (_) -> Void in
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        }
            
        
        alert.addAction(okButton)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
}

// MARK: UIPickerViewDataSource AND ViewDelegate

extension TimerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPicker {
            return 24
        } else if pickerView == minutePicker {
            return 60
        } else {
            return 2 //?
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    
    
}
