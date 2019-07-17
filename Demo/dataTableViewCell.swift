//
//  scanTableViewCell.swift
//  Demo
//
//  Created by Scosche on 2/19/19.
//  Copyright © 2019 Scosche. All rights reserved.
//

import Foundation
import UIKit


class dataTableViewCell: UITableViewCell {
    @IBOutlet var header: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.roundedCorners(top: false, size: 20.0)
    }
    
    func populate(){
        
    }
}
