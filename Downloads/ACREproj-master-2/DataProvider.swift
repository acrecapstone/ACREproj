//
//  DataProvider.swift
//  ACRE_App
//
//  Created by MacMini1 on 10/20/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class DataProvider
{
    //declare members/variables
    
    //methods
    
    func requestAuthentication ()
    {
        let urlPath : String = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        //request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        //NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: &NSError)
            
    
    
    
    }





}

