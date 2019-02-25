//
//  workoutViewController.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/15/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import Foundation
import ScoscheSDK24


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
            }
        }
    }
    
    @IBAction func cancel() {
        self.performSegue(withIdentifier: "unwind", sender: nil)
        
    }
    
    @IBAction func hr() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.heartRate
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func run() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.running
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func cycle() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.cycling
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func swim() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.swimming
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func dua() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.duathlon
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func tri() {
        tempMode = CharacteristicScoscheRhythm24SportMode.SportModeType.triathlon
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    
    
    
    
    
}
