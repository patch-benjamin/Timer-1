//
//  AppearanceController.swift
//  Timer
//
//  Created by Benjamin Patch on 10/19/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import QuartzCore

class AppearanceController {
    
    class func setUpAppearance() {
        
        backGroundUIView.appearance().backgroundColor = UIColor.backGroundColor()
        UIButton.appearance().tintColor = UIColor.buttonTextColor()
        UIButton.appearance().backgroundColor = UIColor.buttonBackGroundColor()
        UINavigationBar.appearance().backgroundColor = UIColor.navBarColor()
        UITabBar.appearance().backgroundColor = UIColor.tabBarColor()
        
    }
    
}