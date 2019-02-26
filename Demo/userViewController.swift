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
    @IBOutlet var unit: UISegmentedControl!
    @IBOutlet var rhr: UITextField!
    @IBOutlet var mhr: UITextField!
    
    
    //MARK:- Local Vars
    var tempUserInfo: ScoscheUserInfo!
    var saveInfo = false
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name.text  = tempUserInfo.name
        dob.text = tempUserInfo.dob
        gender.selectedSegmentIndex = tempUserInfo.gender
        unit.selectedSegmentIndex = tempUserInfo.unit
        weight.text = String(tempUserInfo.weight)
        height.text = String(tempUserInfo.height)
        rhr.text = String(tempUserInfo.restinghr)
        mhr.text = String(tempUserInfo.maxhr)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            if let destinationVC = segue.destination as? dataViewController {
                if saveInfo {
                    destinationVC.returnState = .user
                    destinationVC.userInfo = tempUserInfo
                } else {
                    destinationVC.returnState = .normal
                }
            }
        }
    }
    
    func back(){
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func save() {
        saveInfo = true
        
        // Validate Inputs
        if name.text != ""{
            tempUserInfo.name = name.text!
            name.backgroundColor = UIColor.white
        } else {
            name.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        if dob.text != ""{
            // validate that data can be read
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM/dd/yyyy"
            let testDate = dob.text
            
            if dateFormatterGet.date(from: testDate!) != nil {
                tempUserInfo.dob = dob.text!
                tempUserInfo.age = ScoscheGetAgeInMonths(date: tempUserInfo.dob)
                dob.backgroundColor = UIColor.white
            } else {
                dob.backgroundColor = UIColor.red
                saveInfo = false
            }
            
        } else {
            dob.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        
        
        tempUserInfo.gender = gender.selectedSegmentIndex
        tempUserInfo.unit = unit.selectedSegmentIndex
        
        if weight.text != "" && Double(weight.text!) !=  nil {
            tempUserInfo.weight = Double(weight.text!)!
            weight.backgroundColor = UIColor.white
        } else {
            weight.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        if height.text != "" && Double(height.text!) !=  nil {
            tempUserInfo.height = Double(height.text!)!
            height.backgroundColor = UIColor.white
        } else {
            height.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        if rhr.text != "" && Int(rhr.text!) !=  nil {
            tempUserInfo.restinghr = Int(rhr.text!)!
            rhr.backgroundColor = UIColor.white
        } else {
            rhr.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        if mhr.text != "" && Int(mhr.text!) !=  nil {
            let max = Int(mhr.text!)!
            if max > 100 {
                tempUserInfo.maxhr = max
                tempUserInfo.hrZoneOne = Int(Double(max) * 0.6)
                tempUserInfo.hrZoneTwo = Int(Double(max) * 0.7)
                tempUserInfo.hrZoneThree = Int(Double(max) * 0.8)
                tempUserInfo.hrZoneFour = Int(Double(max) * 0.9)
                mhr.backgroundColor = UIColor.white
            } else {
                mhr.backgroundColor = UIColor.red
                saveInfo = false
            }
        } else {
            mhr.backgroundColor = UIColor.red
            saveInfo = false
        }
        
        if saveInfo {
           back()
        }
        
    }
    
    @IBAction func cancel() {
        back()
    }
    
}
