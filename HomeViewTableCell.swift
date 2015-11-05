//
//  HomeViewTableCell.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/4/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class HomeViewTableCell: UITableViewCell
{
    @IBOutlet weak var homeMenuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}