////
////  TestController.swift
////  ACRE_App
////
////  Created by MacMini1 on 10/27/15.
////  Copyright © 2015 AcreApp.Practice. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class TestController: UIViewController
//{
//    internal func requestAuthentication(email: String, mlsFeedID: String) -> (Bool)
//    {
//        
//        var endpoint = NSURL(string: "http://10.8.1.27/api/user/" + mlsFeedID + "?email=" + email)
//        var data = NSData(contentsOfURL: endpoint!)
//        do {
//            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                if let val = json["value"] as? Bool {
//                    return val
//                }
//            }
//            return false
//        }
//            
//            
//        catch {
//            return false
//        }
//        
//    }
//    
//    print(requestAuthentication(email: "cbboyd2@gmail.com", mlsFeedID: "1"))
//
//
//}