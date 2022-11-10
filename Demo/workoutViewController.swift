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
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    
                    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("fit")
                    var filesToShare = [Any]()
                    print(fileURL)
                    // Add the path of the file to the Array
                    filesToShare.append(fileURL)
                    
                    // Make the activityViewContoller which shows the share-view
                    let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                    
                    // Show the share-view
                    self.present(activityViewController, animated: true, completion: nil)
                })
               
                
            case false:
                print("download unsuccessful")
            }
        }
    }
}

extension Data {
    
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {
        
        // Make a constant from the data
        let data = self
        
        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)
            
        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }
        
        // Returns nil if there was an error in the do-catch -block
        return nil
        
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
}
