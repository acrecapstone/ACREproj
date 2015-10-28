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
    /**var requestAuthenticationTask = NSURLSessionDataTask()
    var session: NSURLSession
        {
            return NSURLSession.sharedSession()
        }**/
    
    func requestAuthentication(email: String, mlsFeedID: Int) -> (Bool)
    {
        //var endpoint = NSURL(string: "https://10.8.1.27/api/user/" + String(mlsFeedID) + "?email=" + email)
        var endpoint = NSURL(string: "http://stackoverflow.com/questions/7950555/how-to-do-validation-on-textfield")
        var data = NSData(contentsOfURL: endpoint!)
        do
        {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                if let val = json["value"] as? Bool
                {
                    print(val)
                    return val
                }
            }
            return false
        }
            
        catch
        {
            return false
        }
    }
    
    
}

/**var requestAuthenticationTask = NSURLSessionDataTask()
var session: NSURLSession
{
return NSURLSession.sharedSession()
}**/




        /**var urlString = "http://10.8.1.27/api/user/1?email=tppatel@crimson.ua.edu"
        if var escapedURLString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        {
            //NSURL(string: escapedURLString)
        }
            let url = NSURL(string: urlString)
            var authenticated: Bool = false
            var requestAuth: String = "failed"
        
            //let PasswordString = "\(email):\(mlsFeedID)"
            //let PasswordData = PasswordString.dataUsingEncoding(NSUTF8StringEncoding)
            //let authenticationCredential = PasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url!)
            //request.setValue("Auth Token \(authenticationCredential)", forHTTPHeaderField: "Authentication")
            request.HTTPMethod = "GET"
        
            let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
            let dataValue: NSData = try! NSURLConnection.sendSynchronousRequest(request, returningResponse: response)
            var error: NSError
        
            if let result: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
            {
                authenticated = (result["data"] as AnyObject? as? Bool!)!
            }
        /*if let result: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
        {
            dictionary["email"] as AnyObject? as? String!
        }*/
        
            if (requestAuth == "success")
            {
                authenticated = true
            }
            else
            {
                authenticated = false
            }
        
            return(authenticated)**/
    
    
    

        /**THIS IS WHAT I USED BEFORE - 10.26.15
        let authenticated: Bool = false

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
                let authentication = jsonResult
                }
            } catch {
                print(error)
            }
        })

        return(authenticated)**/

    
    
    /**var data: NSMutableData = NSMutableData()
    
    //mlsEmail: String, mlsArea: String) -> (Bool)
    func requestAuthentication()
    {
        let urlPath = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        let url = NSURL (string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    {
    self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
    self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection)
    {
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        if jsonResult.count>0 && jsonResult["results"]!.count>0
        {
            var results: NSArray = jsonResult["results"] as! NSArray
            //self.tableData = results
            //self.appsTableView.reloadData()
            
        }
    
        
    
    }**/





/**{
    func requestAuthentication(mlsEmail: String, mlsArea: String) -> (Bool, String)
    {
        let authenticated: Bool = false
        
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
                }
            } catch {
                print(error)
            }
        })
        
        return(authenticated, mlsEmail)
    }
}**/
    
//    { class var SERVER_URL: String { return "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"}}
//
//    class func sendData(data: NSMutableDictionary, service: String, method: String, accessTokenInHeader: Bool, callback: (AnyObject) -> ())
//    {
//        var url: NSURL?
//        var request: NSMutableURLRequest?
//        if method != "GET"
//        {
//            url = NSURL(string: self.SERVER_URL + "/" + service)
//        }
//        else
//        {
//            url = NSURL(string: self.SERVER_URL + "/" + service + ".json?access_token=" + accessToken)
//        }
//        request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 25)
//        if method != "GET"
//        {
//            var jsonError: NSError??
//            let jsonData = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: &jsonError)
//            var jsonLength = String(format: "%ld", jsonData!.length)
//            request?.setValue(jsonLength, forHTTPHeaderField: "Content-Length")
//            request?.setValue("json", forHTTPHeaderField: "Data-Type")
//            request?.HTTPBody = jsonData
//        }
//        request?.HTTPMethod = method
//        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request?.setValue("application/json", forHTTPHeaderField: "Accept")
//
//        let queue: NSOperationQueue = NSOperationQueue()
//        NSURLConnection.sendAsynchronousRequest(request!, queue: queue, completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var err: NSError?
//            if err?.localizedDescription != nil
//            {
//                callback(false)
//            }
//            else
//            {
//                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
//                callback(jsonResult)
//            }
//        })
//    }







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
