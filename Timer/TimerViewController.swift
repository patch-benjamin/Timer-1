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
        if startCancelButton.titleLabel?.text == "Start" {
            labelOnView()
            setTimer()
        } else {
            labelOffView()
        }
    }
    
    @IBAction func pauseTouched(sender: UIButton) {
    }
    
    func setTimer(){
        // get values at hourpicker and minute picker
        //convert it to seconds
        // call timer.setTime with the seconds
        timer.setTime(NSTimeInterval(30), totalSeconds: NSTimeInterval(30))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCancelButton.layer.borderColor = UIColor.buttonTextColor().CGColor
        startCancelButton.layer.borderWidth = 3
        
        pauseButton.layer.borderColor = UIColor.buttonTextColor().CGColor
        pauseButton.layer.borderWidth = 3
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "timeLabelUpdate", name: Timer.TimerSecondTickNotification, object: nil)
        nc.addObserver(self, selector: "labelOffView", name: Timer.TimerCompleteNotification, object: nil)
    }
    
    func timeLabelUpdate() {
        timerLabel.text = timer.timerString()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func labelOffView(){
        // turn off label and progressbar
        progressBar.hidden = true
        timerLabel.hidden = true
        
        //turn on view with selectors
        pickerStackView.hidden = false
        
        // set button to "start"
        startCancelButton.setTitle("Start", forState: .Normal)
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

    
}


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
