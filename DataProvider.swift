//
//  DataProvider.swift
//  ACRE_App
//
//  Created by MacMini1 on 10/20/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

/**import Foundation
import UIKit

class DataProvider
{
    //declare members/variables
    
    //methods
    
    func requestAuthentication ()
    {
        
        //calling the get post for API - request authentication
        let urlPath : String = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var dataVal: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)
        var err: NSError
        print(response)
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: err) as? NSDictionary)!
        print(Synchronous/(jsonResult))
        

        //request.URL = NSURL(string: url)
        //request.HTTPMethod = "GET"
    
    }

}**/


