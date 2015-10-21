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
    func requestAuthentication(mlsEmail: String, mlsArea: String) -> (Bool)
    {
        var authenticated: Bool = false
        
        let urlPath = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        let url = NSURL (string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
        print ("Task Completed")
            if(error != nil) { print (error!.localizedDescription) }
            var error: NSError?
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    print(jsonResult)
                    let authenticated = jsonResult.bool
                    }
                }
            } catch {
                print(error)
            }
        })
        
        return(authenticated)
    }

    


//        let urlString = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
//        let url = NSURL(string: urlString)
//        var authenticated: Bool = false
//
//        let request = NSMutableURLRequest = NSMutableURLRequest(URL: url!)
//        request.setValue("Basic \(base64EncodedCredential)", forHTTPHeaderField: "Authorization")
//        request.HTTPMethod = "GET"
//
//        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
//        let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
//        var error: NSError
//        do {
//            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                print(jsonResult)
//            }
//        } catch {
//            print(error)
//        }



        /**calling the get post for API - request authentication
        let urlPath = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, resonse, error -> Void in
            println("Task completed")
            if(error != nil) {
                println(error.localizedDescription)
            }
        var err: NSError?
            if let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                if(err != nil) {
                    println("JSON Error \ (err!.localizedDescription)")
                }
                if let results: NSArray = jsonResult("results") as? NSArray {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableData = results
                        self.appsTableView!.reloadData()
                    }
                }
            }
            example of loading data into table view, but same idea
            
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var dataVal: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: nil)
        
        print(response)
        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: err) as? NSDictionary)!
        print(Synchronous/(jsonResult))
        
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"**/