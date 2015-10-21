//
//  LoginDataProvider.swift
//  ACRE_App
//
//  Created by MacMini1 on 10/13/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LoginDataProvider{

    var loginTask = NSURLSessionDataTask()
    var session: NSURLSession{ return NSURLSession.sharedSession()}

    func login(mlsEmail: String, authenticationToken: String) -> (Bool, User!) {
    
        let urlString = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        
        let url = NSURL(string: urlString)
        var authenticated: Bool = false
        var requestLogin: String = "failed"
        var mlsEmails: NSDictionary!
        var feedId: String = ""
        var appUser: User!
        
        let authenticationString = "\(mlsEmail):\(authenticationToken)"
        let authenticationTokenData
    }
}

