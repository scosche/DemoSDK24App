//
//  scanTableViewCell.swift
//  Demo
//
//  Created by Steffin Fox Griswold on 2/19/19.
//  Copyright © 2019 NPE INC. All rights reserved.
//

import Foundation
import UIKit


class scanTableViewCell: UITableViewCell {
    @IBOutlet var header: UILabel!
    @IBOutlet var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.roundedCorners(top: false, size: 20.0)
    }
    
    func populate(){
        
    }
}
