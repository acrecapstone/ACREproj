//
//  RequestAuthenticationTokenViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/12/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit
@available(iOS 8.0, *)
class RequestAuthenticationTokenViewController: UIViewController, UIPickerViewDataSource, NSURLConnectionDataDelegate, UIPickerViewDelegate, UITextFieldDelegate
{
    //variables
    @IBOutlet weak var requestAuthenticationTitleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var requestToken: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var mlsEmailLabel: UILabel!
    @IBOutlet weak var mlsAreaLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var mlsEmailTextField: UITextField?
    @IBOutlet weak var mlsAreaPickerView: UIPickerView?
    var passedLogin = false
    
    let dataProvider = DataProvider()
    //var mlsEmail = String()
    
    @IBAction func requestAuthTokenPassword(sender: AnyObject)
    {
        
        //Hardcoded requestAuth func
        //print(dataProvider.requestAuthentication("cbboyd2@gmail.com", mlsFeedID: 1))
        
        //Note that it is selected row + 1 to align the wheel index to the mls values in the databases
        
        //uncomment this to re allow authentication system - Walker
        //let authenticated = dataProvider.requestAuthentication(mlsEmailTextField!.text!, mlsFeedID: mlsAreaPickerView!.selectedRowInComponent(0)+1)
        
        let authenticated = true
        if (authenticated == true){
            //pushes to the login page
            loginButton.hidden = false
            passwordLabel.hidden = false
            passwordText.hidden = false
            loginLabel.hidden = false
            requestToken.hidden = true
            requestAuthenticationTitleLabel.hidden = true
        }
        else{
            let alertView: UIAlertView = UIAlertView()
            alertView.title = "Email does not exist!"
            alertView.message = "Please enter correct email!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    
    @available(iOS 8.0, *)
    @IBAction func signInButton(sender: AnyObject)
    {
        
        print("Mlsarea: \(pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)])")
        print("email: \(mlsEmailTextField!.text!)")
        print("mlsAreaID: \(mlsAreaPickerView!.selectedRowInComponent(0)+1)")
        
        //uncomment this to re allow authentication system - Walker
        //let logInAccess = dataProvider.getAccess(mlsEmailTextField!.text!, mlsFeedID: mlsAreaPickerView!.selectedRowInComponent(0)+1, password: passwordText!.text!)
        
        let logInAccess = true
        if (logInAccess == true)
        {
            let secondViewController: SWRevealViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("menuSegue") as AnyObject? as? SWRevealViewController)!
            self.showViewController(secondViewController, sender: self)
        }
        else
        {
            let alertView: UIAlertView = UIAlertView()
            alertView.title = "Sign-In Failed"
            alertView.message = "Please enter correct authentication token!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    //picker view -- how to insert data into picker view
    var pickerDataSource = ["GAL-MLS", "Tuscaloosa"];
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerDataSource[row]
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if (dataProvider.withinTimeThreshold()) {
            //User has logged in previously within valid time frame
            self.view.hidden = true
        }
        else {
            //User has not successfully authenticated within in the past two hours and thus will attempt to auto reauthenticate
            
            //self.passedLogin = dataProvider.requestAuthentication( SQLlite query results)
            
            self.passedLogin = false
            if (passedLogin != false) {
                //Login was passed
                self.view.hidden = true
                
                //Get default area ID
                //Get isMonthly
                
                //hD = dataProvider.requestHomeData( defaultAreaID )
                //Store HD in Stats page, mark isDefault = true, mark isMonthly = isMonthly, set timestamp
            }
            else {
                //Auto log-in failed, attempting to try again
                
                //self.passedLogin = dataProvider.requestAuthentication(  )
                
                if (passedLogin != false) {
                    
                    //Login succeeded on second attempt
                    
                    //Get default area ID
                    //Get isMonthly
                    
                    //hD = dataProvider.requestHomeData( defaultAreaID )
                    //Store HD in Stats page, mark isDefault = true, mark isMonthly = isMonthly, set timestamp
                    
                    self.view.hidden = true
                }
                else {
                    //Login Failed, sending to request authentication at users choosing or to reauthenticate completely
                    
                    //Show retry auth button??
                    
                    self.view.hidden = false
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if (self.passedLogin != false) {
            let secondViewController: SWRevealViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("menuSegue") as AnyObject? as? SWRevealViewController)!
            self.showViewController(secondViewController, sender: self)
        }
        else {
            //Display error message
            
            //User will be sent to reauthenticate
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.mlsEmailTextField!.delegate = self;
        self.mlsAreaPickerView!.dataSource = self;
        self.mlsAreaPickerView!.delegate = self;
        
        loginLabel.hidden = true
        loginButton.hidden = true
        passwordLabel.hidden = true
        passwordText.hidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

