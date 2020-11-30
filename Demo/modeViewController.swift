//
//  workoutViewController.swift
//  Demo
//
//  Created by Scosche on 2/15/19.
//  Copyright © 2019 Scosche. All rights reserved.
//

import Foundation
import ScoscheSDK24
import UIKit

class modeViewController: UIViewController {
    //MARK:- IB Refs
    
    
    
    //MARK:- Local Vars
    var tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.heartRate
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            if let destinationVC = segue.destination as? dataViewController {
                destinationVC.sportMode = tempMode
                destinationVC.returnState = .mode
            }
        }
    }
    func back(){
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func cancel() {
        back()
    }
    
    @IBAction func hr() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.heartRate
        back()
    }
    
    @IBAction func run() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.running
        back()
    }
    
    @IBAction func cycle() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.cycling
        back()
    }
    
    @IBAction func swim() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.swimming
        back()
    }
    
    @IBAction func dua() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.duathlon
        back()
    }
    
    @IBAction func tri() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.triathlon
        back()
    }
    
    
}
