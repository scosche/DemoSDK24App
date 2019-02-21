//
//  dataViewController.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/15/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import Foundation
import ScoscheSDK24
import CoreBluetooth


class dataViewController: SchoscheViewController {
    //MARK:- IB Refs
    
    
    
    //MARK:- Local Vars
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ConnectToDevice(monitor: monitor, UIview: self)
        poll()
    }
    
    func poll(){
        print("hr: \(heartRate)")
        print("signal: \(signalQuality)")
        print("batt: \(batteryLevel)")
        print("user age: \(ageInMonths)")
        delay(10) {
            self.poll()
        }
    }
}
