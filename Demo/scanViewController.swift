//
//  ViewController.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/14/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import UIKit
import ScoscheSDK24


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
        
        //Lets make sure we nil things out
        discoveredMonitors.removeAll()
        ScoscheDeviceReset()
        ScoscheDeviceScan(UIview: self)
        
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
        ScoscheDeviceScan(UIview: self)
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
        ScoscheDeviceStopScan(UIview:self)
        self.performSegue(withIdentifier: "gotoData", sender: nil)
    }
}

