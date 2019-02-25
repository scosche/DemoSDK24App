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


class dataViewController: SchoscheViewController, UITableViewDelegate, UITableViewDataSource  {
    //MARK:- IB Refs
    
    @IBOutlet var tableview: UITableView!
    
    
    //MARK:- Local Vars
    var listData: [String] = []
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ConnectToDevice(monitor: monitor, UIview: self)
        listData.append("Start Up: \(monitor.deviceName ?? "Unknown")")
       // reloadTableData()
    }
    
    override func reloadTableData(){
        listData = []
        listData.append("Sensor Name: \(monitor.deviceName ?? "Unknown")")
        listData.append("Connection Status: \(connected)")
        listData.append("Heart Rate: \(heartRate)")
        listData.append("Resting Heart Rate: \(restingHeartRate)")
        listData.append("Signal Quality: \(signalQuality)")
        listData.append("Battery Level: \(batteryLevel)")
        listData.append("User Name: \(userInfo.name)")
        listData.append("Gender: \(userInfo.gender)")
        listData.append("Age: \(userInfo.age)")
        listData.append("Weight: \(userInfo.weight)")
        listData.append("Height: \(userInfo.height)")
        listData.append("FitFile Count: \(fitFileList.count)")
        tableview.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWorkout" {
            if let destinationVC = segue.destination as? workoutViewController {
                destinationVC.monitor = monitor
            }
        }
        if segue.identifier == "gotoUser" {
            if let destinationVC = segue.destination as? userViewController {
                destinationVC.monitor = monitor
            }
        }
    }
    @IBAction func unwindToData(_ unwindSegue: UIStoryboardSegue) {
        // do the thing
    }
    
    //MARK:- Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! dataTableViewCell
        cell.header.text = listData[indexPath.row]
        return cell
      
        
    }
    
}
