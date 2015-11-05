//
//  FavoriteAreasTableViewCell.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/3/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class FavoriteAreasTableViewCell: UITableViewCell
{
    @IBOutlet weak var areaName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}