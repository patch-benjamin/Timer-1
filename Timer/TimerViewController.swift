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
        
    // MARK: Outlets
    
    // First View:
    @IBOutlet weak var hourPicker: UIPickerView!
    
    @IBOutlet weak var minutePicker: UIPickerView!
    
    // Second View
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressView: UIView!
    
    
    
    
    
    
    // MARK: Actions
    
    @IBAction func startTouched(sender: UIButton) {
        
    }
    
    @IBAction func pauseTouched(sender: UIButton) {
    }
    
    @IBAction func stopButtonTouched(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
