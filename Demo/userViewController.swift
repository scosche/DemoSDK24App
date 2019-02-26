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
        tempUserInfo.name = name.text ?? "Unknown"
        tempUserInfo.dob = name.text ?? "1/1/1970"
        tempUserInfo.age = ScoscheGetAgeInMonths(date: tempUserInfo.dob)
        tempUserInfo.gender = gender.selectedSegmentIndex
        tempUserInfo.unit = unit.selectedSegmentIndex
        if unit.selectedSegmentIndex == 1 {
            tempUserInfo.weight = Double(weight.text!) ?? 81.6
            tempUserInfo.height = Double(height.text!) ?? 178.0
        } else {
            tempUserInfo.weight = Double(weight.text!) ?? 180
            tempUserInfo.height = Double(height.text!) ?? 70
        }
        tempUserInfo.restinghr = Int(rhr.text!) ?? 70
        back()
    }
    
    @IBAction func cancel() {
        back()
    }

   
    
}
