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
    @IBOutlet weak var retryAuth: UIButton!
    var passedLogin = false
    var pickerDataSource = [MLSFeed]()
    let FEDL = FEDataLayer()
    let dataProvider = DataProvider()
    
    @IBAction func requestAuthTokenPassword(sender: AnyObject)
    {
        //uncomment this to re allow authentication system - Walker
        let authenticated = dataProvider.requestAuthentication(mlsEmailTextField!.text!, mlsFeedID: mlsAreaPickerView!.selectedRowInComponent(0)+1)
        
        //let authenticated = true
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
    
    
    //@available(iOS 8.0, *)
    @IBAction func signInButton(sender: AnyObject)
    {
        
        //uncomment this to re allow authentication system - Walker
        let logInAccess = dataProvider.getAccess(mlsEmailTextField!.text!, mlsFeedID: pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)].mlsFeedID, password: passwordText!.text!)
        
        //let logInAccess = true
        if (logInAccess == true)
        {
            let validFeedIDs = FEDL.getValidAgentFeedIDs()
            //Subsequent login, agent will likely be replaced
            if validFeedIDs.contains(pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)].mlsFeedID) {
                
                FEDL.deleteAgent(pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)].mlsFeedID)
                
                FEDL.addAgent(passwordText!.text!, mlsFeedID: pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)].mlsFeedID, email: mlsEmailTextField!.text!, isAuth: true)
                
                let secondViewController: SWRevealViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("menuSegue") as AnyObject? as? SWRevealViewController)!
                self.showViewController(secondViewController, sender: self)
                
            }
            //First Time Login
            else {
                FEDL.addAgent(passwordText!.text!, mlsFeedID: pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)].mlsFeedID, email: mlsEmailTextField!.text!, isAuth: true)
                
                let secondViewController: SWRevealViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("initDefaultArea") as AnyObject? as? SWRevealViewController)!
                self.showViewController(secondViewController, sender: self)
            }
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
    
    @IBAction func retryAuthButton(sender: AnyObject) {
    }
    
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
        return pickerDataSource[row].mlsFeedName
    }
    
    override func viewWillAppear(animated: Bool) {
    
        //fix timeThreshold function
        //User has logged in previously within valid time frame
        if (false) {
            self.view.hidden = true
        }
        //User has not successfully authenticated within in the past two hours and thus will attempt to auto reauthenticate
        else {
            var validUserFound = false
            let agents = FEDL.getValidAgents()
            for agnt in agents {
                self.passedLogin = dataProvider.getAccess(agnt.agentEmail, mlsFeedID: agnt.mlsFeedID, password: agnt.authToken)
                //self.passedLogin = false
                if (passedLogin) {
                    FEDL.updateLastLogin(agnt.mlsFeedID)
                    var blah = FEDL.getValidLastLogin(1)
                    //uncomment this when default area is implemented
                    //var defID = FEDL.getDefaultAreaID()
                    let defID = 1
                    let hD = dataProvider.requestHomeData(defID)
                    hD.isDefault = true
                    //uncomment this when default area is implemented
                    //hD.isMonthly = FEDL.getDefaultTimePref()
                    hD.isMonthly = true
                    hD.timestamp = NSDate()
                    print("hD: ")
                    print(String(hD.timestamp))
                    FEDL.deleteStat(defID)
                    FEDL.addStat(hD)
                    validUserFound = true
                }
                else {
                    //Auto log-in failed, attempting to try again
                    self.passedLogin = dataProvider.getAccess(agnt.agentEmail, mlsFeedID: agnt.mlsFeedID, password: agnt.authToken)
                    //self.passedLogin = false
    
                    if (passedLogin) {
    
                        //Login succeeded on second attempt
    
                        ///uncomment this when default area is implemented
                        //var defID = FEDL.getDefaultAreaID()
                        let defID = 1
                        let hD = dataProvider.requestHomeData(defID)
                        hD.isDefault = true
                        //uncomment this when default area is implemented
                        //hD.isMonthly = FEDL.getDefaultTimePref()
                        hD.isMonthly = true
                        hD.timestamp = NSDate()
                        FEDL.deleteStat(defID)
                        FEDL.addStat(hD)
                        validUserFound = true
                    }
                    else {
                        //Login Failed, sending to request authentication at users choosing or to reauthenticate completely
                        FEDL.invalidateAgent(agnt.mlsFeedID)
                        loginButton.hidden = true
                        retryAuth.hidden = false
                    }
                }
                //Decide whether to display page or not
                if validUserFound {
                    self.view.hidden = true
                }
                else {
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
            let alertView: UIAlertView = UIAlertView()
            alertView.title = "Auto Sign-In Failed for feed(s)"
            alertView.message = "Please re-request authentication. If the issue persists please contact your MLS Provider"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
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
        retryAuth.hidden = true
        pickerDataSource = FEDL.getMLSFeeds()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

