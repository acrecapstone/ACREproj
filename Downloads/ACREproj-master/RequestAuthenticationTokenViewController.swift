//
//  RequestAuthenticationTokenViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/12/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit
//import Alamofire


class RequestAuthenticationTokenViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate
{
    //variables
    @IBOutlet weak var requestAuthenticationTitleLabel: UILabel!
    @IBOutlet weak var mlsEmailLabel: UILabel!
    @IBOutlet weak var mlsAreaLabel: UILabel!
    @IBOutlet weak var mlsEmailTextField: UITextField!
    @IBOutlet weak var mlsAreaPickerView: UIPickerView!

    //request token button
    @IBAction func requestAuthTokenPassword(sender: AnyObject) {
        
        //declare parameters as a dictionary
        //var parameters = ["email": mlsEmailTextField.text, "area": mlsAreaPickerView.description] as Dictionary<String, String>
        
        
        //create the URL with NSURL
        let url = NSURL(string: "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com")
        
        //create the session object
        var session = NSURLSession.sharedSession()
        
        //create the NSMutualRequest object using the url object
        let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
        
        var error: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &error) //pass dictionary to nsdata object and set it as request body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        print("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("Body: \(strData)")
            var error: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error) as? NSDictionary
            
        //did the jsonObjectwithData constructor return an error? If so, log the error
            if (error != nil){
                print(error!.localizedDescription)
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            } else {
            //okay the json object was nil, something went wrong. 
            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        })
    
        task.resume()

        //this will show the keyboard when clicking on email text field and then remove keyboard when done
        mlsEmailTextField.resignFirstResponder();
        mlsEmailTextField.text = mlsEmailTextField.text;
        //read the selected MLS Area
        
        /**if mlsEmailTextField != nil{
            self.performSegueWithIdentifier("logInPageSegue", sender: self)
        }**/
        
        /**let logInVC = LoginPageViewController(nibName: "LoginPageViewController", bundle: nil)
        navigationController?.pushViewController(logInVC, animated: true)**/
        
        //sends a request to chris based on the email received from user
        /**Alamofire.request(.GET, "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com")**/
        
        /**let url = NSURL(string: "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com")
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true))**/
    }
    
    /**func connection (connection: NSURLConnection!, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge!)
    {
        if challenge.previousFailureCount > 1 {
        } else {
        
            let creds = NSURLCredential(user: mlsEmailTextField.text, area: mlsAreaPickerView, persistence: NSURLCredentialPersistence.None)
            challenge.sender?.useCredential(creds, forAuthenticationChallenge: challenge)
            
        }
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse)
    {
        let status = (response as! NSHTTPURLResponse).statusCode
        //this should then push to login page
    }**/
    
    
    //this will post data to the url
    /**func postDataSynchronous(url: String, bodyData: String, completionHandler: (reponseString: String!, error: NSError!) -> ())
    {
        var URL: NSURL = NSURL(string: url)!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var response: NSURLResponse?
        var error: NSError?
        
        NSURLConnection.sendSynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
        response, data, error in
            var output: String!
            
            if data != nil {
                output = NSString (data: data, encoding: NSUTF8StringEncoding) as! String
            }
            
            completionHandler(reponseString: output, error: error)
        }
    }**/

    
    
    
    
    
    
    
    
    //picker view -- how to insert data into pick889er view
    var pickerDataSource = ["Greater Alabama", "Tuscaloosa"];

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mlsEmailTextField.delegate = self;
        self.mlsAreaPickerView.dataSource = self;
        self.mlsAreaPickerView.delegate = self;
    }
        /**DataManager.getEmailDataFromUserWithSucess { (data) -> Void in
        var parseError: NSError?
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&parseError)
        
            if let emails = parsedObject as? NSDictionary {
                if let feed = emails["feed"] as? NSDictionary{
                    if let apps = feed["entry"] as NSArray {
                        if let firstApp = apps[0] as? NSDictionary{
        
                        }
                }
            }**/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


    /**Alamofire.request(.GET, "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com=mlsEmailTextField").responseJSON {(request, response, json, error) in if json != nil { var jsonObj = JSON(json!)
            if let data = jsonObj["data"].arrayValue as [JSON]? {
            self.datas = data
            self.mlsEmailTextField.reloadData()}}**/
        
       /** Alamofire.request(.GET, "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com").responseJSON {(request, response, json, error) in if json != nil { println(json) } }**/
       /** Alamofire.request(.GET, "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com").responseJSON { (_,_,) in printIn(data) **/
            
        /**XCPSetExecutionShouldContinueIndefinitely(){
            
            /**
            * Paste all the code from the following file
            - https://github.com/lingoer/SwiftyJSON/blob/master/SwiftyJSON/SwiftyJSON.swift
            **/
            
            let urlPath = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
            let url: NSURL = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
                
                if error != nil {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                
                var err: NSError?
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if err != nil {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                
                let json = JSONValue(jsonResult)
                let count: Int? = json["data"].array?.count
                println("found \(count!) challenges")
                
                if let ct = count {
                    for index in 0...ct-1 {
                        // println(json["data"][index]["challengeName"].string!)
                        if let name = json["data"][index]["challengeName"].string {
                            println(name)
                        }
                        
                    }
                }
            })
            task.resume()
        }**/
        // Do any additional setup after loading the view, typically from a nib.**/
    /**override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.**/


