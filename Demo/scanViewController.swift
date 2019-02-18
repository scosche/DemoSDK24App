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

    
    //MARK:- IB Refs
    @IBOutlet var tableview: UITableView!
    
    
    
    
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Lets make sure we nil things out
        discoveredMonitors.removeAll()
        ScoscheDeviceReset()
        
    }
    
    //MARK:- IB Actions
    @IBAction func scanButton() {
        
    }
    
    //MARK:- Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return discoveredMonitors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "opsCell", for: indexPath as IndexPath)
        let monitor: ScoscheMonitor = discoveredMonitors[indexPath.row]
        let connectString = "Scan View: Monitor Table Cell - Connect Message"
        cell.textLabel?.text = monitor.deviceName ?? ""
        cell.detailTextLabel?.text = connectString
        return cell
    }
}

