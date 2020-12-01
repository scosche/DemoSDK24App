//
//  ViewController.swift
//  Demo
//
//  Created by Scosche on 2/14/19.
//  Copyright © 2019 Scosche. All rights reserved.
//

import UIKit
import ScoscheSDK24
import UIKit

//DELAY
func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

/// scanViewController: Demo of scanning for known Scosche devices with BLE interface. View uses ScoscheViewController to extend a standard UIViewController with services that report monitor activity.
///
/// - Parameter monitor: ScoscheMonitor
class scanViewController: SchoscheViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Row{
        case blank
        case device
    }
    
    var row: Row = .blank

    //MARK:- IB Refs
    @IBOutlet var tableview: UITableView!
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Scan View")
        delay(1) {
            print("Scan Start")
            // this delay is only here because App is scanning too close to app launch
            self.discoveredMonitors.removeAll()
            ScoscheDeviceReset()
            ScoscheDeviceScan(monitorView: self)
        }
        
        
    }
    override func reloadTableData(){
        if discoveredMonitors.count > 0 {
            row = .device
        } else {
            row = .blank
        }
        print("Monitors: \(discoveredMonitors.count)")
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoData" {
            if let destinationVC = segue.destination as? dataViewController {
                destinationVC.monitor = monitor
            }
        }
    }
    
    //MARK:- IB Actions
    @IBAction func scanButton() {
        ScoscheDeviceScan(monitorView: self)
    }
    
    //MARK:- Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch row {
        case .device:
            return discoveredMonitors.count
        case .blank:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch row {
        case .device:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! scanTableViewCell
            let monitor: ScoscheMonitor = discoveredMonitors[indexPath.row]
            cell.header.text = "Device Name: \(monitor.deviceName ?? "Unnamed")"
            cell.accessoryType = .disclosureIndicator
            return cell
        case .blank:
            let cell = tableView.dequeueReusableCell(withIdentifier: "blankcell", for: indexPath as IndexPath)
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        monitor = discoveredMonitors[indexPath.row]
        ScoscheDeviceStopScan(monitorView: self)
        self.performSegue(withIdentifier: "gotoData", sender: nil)
    }
}

