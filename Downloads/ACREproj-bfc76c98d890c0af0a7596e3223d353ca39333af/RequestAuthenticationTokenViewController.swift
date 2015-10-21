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

    //var datas: [JSON] = []
    
    //request token button
    @IBAction func requestAuthTokenPassword(sender: AnyObject) {
        
        
        //let urlPath: String = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
        //let url = NSURL(string: urlPath)!
        //var request: NSURLRequest = NSURLRequest(URL: url)
        //var connection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
        //connection.start()
        
        //this will show the keyboard when clicking on email text field and then remove keyboard when done
        //mlsEmailTextField.resignFirstResponder();
        //mlsEmailTextField.text = mlsEmailTextField.text;
        //read the selected MLS Area
        
        /**if mlsEmailTextField != nil{
            self.performSegueWithIdentifier("logInPageSegue", sender: self)
        }**/
        
        /**let logInVC = LoginPageViewController(nibName: "LoginPageViewController", bundle: nil)
        navigationController?.pushViewController(logInVC, animated: true)**/
        
    }
    
    func connection (connection: NSURLConnection!, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge!)
    {
        if challenge.previousFailureCount > 1 {
        } else {
        
            let creds = NSURLCredential(user: mlsEmailTextField.text!, password: "", persistence: NSURLCredentialPersistence.None)
            
            challenge.sender?.useCredential(creds, forAuthenticationChallenge: challenge)
            
        }
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse)
    {
        //let status = (response as! NSHTTPURLResponse).statusCode
        //this should then push to login page
    }
    
    
    //picker view -- how to insert data into picker view
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
    /**override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()



