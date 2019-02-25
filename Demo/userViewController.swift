//
//  workoutViewController.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/15/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import Foundation
import ScoscheSDK24


class userViewController: UIViewController {
    //MARK:- IB Refs
    
    @IBOutlet var name: UITextField!
    @IBOutlet var dob: UITextField!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var weight: UITextField!
    @IBOutlet var height: UITextField!
    
    
    //MARK:- Local Vars
    var tempUserInfo: UserInfo!
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func save() {
        
    }
    
    @IBAction func cancel() {
    }
    
}
