//
//  AlarmViewController.swift
//  Timer
//
//  Created by Benjamin Patch on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    // MARK: Properties
    
    var alarm = Alarm()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmSetLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var setCancelButton: UIButton!

    
    
    // MARK: Actions
    
    @IBAction func setCancelButtonTapped(sender: UIButton) {
        
        if !alarm.isAlarmed {
            if let currentDate = datePicker?.date {
                alarm.arm(currentDate)
            }
            setCancelButton.setTitle("Cancel Alarm", forState: .Normal)
            
            alarmTimeLabel.text = alarm.getDateString()
            alarmSetLabel.text = "You alarm is set!"
            
        } else {
            
            alarm.cancel()
            setCancelButton.setTitle("Set Alarm", forState: .Normal)
            alarmTimeLabel.text = ""
            alarmSetLabel.text = "You alarm is not set."
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.minimumDate = NSDate()
        
        // Observe NSNotification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "alarmComplete", name: Alarm.kAlarmCompleteNotification, object: alarm)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alarmComplete() {
        alarm.cancel()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
