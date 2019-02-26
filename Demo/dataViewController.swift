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
    
    enum cellType {
        case normal
        case user
        case mode
        case fit
    }
    struct cellRow {
        let type: cellType
        let value: String
    }
    
    //MARK:- Local Vars
    var listData: [cellRow] = []
    var returnState: cellType = .normal
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ConnectToDevice(monitor: monitor, UIview: self)
        listData.append(cellRow(type: .normal, value: "Start Up: \(monitor.deviceName ?? "Unknown")"))
    }
    
    override func reloadTableData(){
        listData = []
        listData.append(cellRow(type: .normal, value: "Sensor Name: \(monitor.deviceName ?? "Unknown")"))
        if monitor.r24SportMode != nil {
            listData.append(cellRow(type: .mode, value: "Sport Mode: \(sportMode.stringValue)"))
        }
        listData.append(cellRow(type: .normal, value: "Connection Status: \(connected)"))
        listData.append(cellRow(type: .normal, value: "Heart Rate: \(heartRate)"))
        
        listData.append(cellRow(type: .normal, value: "Signal Quality: \(signalQuality)"))
        listData.append(cellRow(type: .normal, value: "Battery Level: \(batteryLevel)"))
        listData.append(cellRow(type: .user, value: "User Name: \(userInfo.name)"))
        listData.append(cellRow(type: .user, value: "Resting Heart Rate: \(userInfo.restinghr)"))
        listData.append(cellRow(type: .user, value: "Maximum Heart Rate: \(userInfo.maxhr)"))
        listData.append(cellRow(type: .user, value: "Gender: \(userInfo.gender)"))
        listData.append(cellRow(type: .user, value: "Age: \(userInfo.age)"))
        listData.append(cellRow(type: .user, value: "Weight: \(userInfo.weight)"))
        listData.append(cellRow(type: .user, value: "Height: \(userInfo.height)"))
        listData.append(cellRow(type: .normal, value: "Zone One: \(userInfo.hrZoneOne)"))
        listData.append(cellRow(type: .normal, value: "Zone Two: \(userInfo.hrZoneOne)"))
        listData.append(cellRow(type: .normal, value: "Zone Three: \(userInfo.hrZoneOne)"))
        listData.append(cellRow(type: .normal, value: "Zone Four: \(userInfo.hrZoneOne)"))
        listData.append(cellRow(type: .fit, value: "FitFile Count: \(fitFileList.count)"))
        tableview.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWorkout" {
            if let destinationVC = segue.destination as? workoutViewController {
                destinationVC.fitFileList = fitFileList
            }
        }
        if segue.identifier == "gotoUser" {
            if let destinationVC = segue.destination as? userViewController {
                destinationVC.tempUserInfo = userInfo
                
            }
        }
        if segue.identifier == "gotoMode" {
            if let destinationVC = segue.destination as? modeViewController {
                destinationVC.tempMode = sportMode
            }
        }
    }
    @IBAction func unwindToData(_ unwindSegue: UIStoryboardSegue) {
        print("Unwind to data view")
        
        if returnState == .user {
            ScoscheDeviceUpdateInfo(monitor: monitor, userInfo: userInfo)
        }
        if returnState == .mode {
            self.onModeChangeAction?(sportMode)
        }
        reloadTableData()
    }
    
    //MARK:- Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = listData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! dataTableViewCell
        cell.header.text = row.value
        if row.type == .normal {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = listData[indexPath.row]
        if row.type == .fit {
           self.performSegue(withIdentifier: "gotoWorkout", sender: nil)
        }
        if row.type == .user {
            self.performSegue(withIdentifier: "gotoUser", sender: nil)
        }
        if row.type == .mode {
            self.performSegue(withIdentifier: "gotoMode", sender: nil)
        }
    }
    
}
