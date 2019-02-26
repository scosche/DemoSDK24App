//
//  workoutViewController.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/15/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import Foundation
import ScoscheSDK24


class workoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- IB Refs
    @IBOutlet var tableview: UITableView!
    
    
    //MARK:- Local Vars
    var fitFileList: [FitFileMetaData] = []
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = fitFileList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! dataTableViewCell
        cell.header.text = row.localModificationDate
        return cell
    }
}
