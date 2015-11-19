//
//  Agent.swift
//  ACRE_App
//
//  Created by ACRE on 11/17/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class Agent {
    var agentID = Int()
    var authToken = String()
    var agentEmail = String()
    var lastLogin = NSDate()
    var mlsFeedID = Int()
    var isAuth = Bool()
    
    init() {
        self.agentID = 0
        self.authToken = ""
        self.agentEmail = ""
        self.lastLogin = NSDate()
        self.mlsFeedID = 0
        self.isAuth = false
    }
}