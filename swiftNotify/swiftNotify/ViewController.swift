//
//  ViewController.swift
//  swiftNotify
//
//  Created by Mrudul P on 12/02/15.
//  Copyright (c) 2015 Mrudul P. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = NSTimer();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invokeNotification()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startNotify(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("invokeNotification"),userInfo: nil, repeats: true);
    }
    
    @IBAction func stopNofity(sender: AnyObject) {
        timer.invalidate();
    }
    
    func invokeNotification() {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "Local notifications are working"
        localNotification.fireDate = nil
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.category = "invite"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }


}

