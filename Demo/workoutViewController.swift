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


class workoutViewController: SchoscheViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- IB Refs
    @IBOutlet var tableview: UITableView!
    @IBOutlet var downloadLabel: UILabel!
    
    
    //MARK:- Local Vars
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func back(){
        self.performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func cancel() {
        back()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitFileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = fitFileList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! dataTableViewCell
        if row.modificationDate != nil {
            cell.header.text = row.modificationDate?.description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Download and get Progress
        let file = fitFileList[indexPath.row]
        
        // Set File Name
        let df = DateFormatter()
        df.dateFormat = "yyyy_MM_dd_hh_mm"
        let now = df.string(from: file.modificationDate ?? Date())
        let num = "\(file.fileIndex)_\(file.fileNumber)"
        let fileName = "\(now)_\(num)"
        
        // Start download and callback options
        ScoscheDownloadFitFile(fitMetaData: file, fileName: fileName, label: downloadLabel) { (success) in
            switch success {
            case true:
                print("download successful")
            case false:
                print("download unsuccessful")
            }
        }
    }
}
