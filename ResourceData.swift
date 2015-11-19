//
//  ResourceData.swift
//  ACRE_App
//
//  Created by MacMini1 on 11/17/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class ResourceData
{
    var resourceID = Int()
    var label = String()
    var url = String()
    //var convertedLink = NSURL();
    
    init()
    {
        self.resourceID = -1
        self.label = " "
        self.url = ""
        //self.convertedLink = NSURL();
    }
}