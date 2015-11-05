//
//  RequestAuthenticationTokenViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/12/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

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

    let dataProvider = DataProvider()
    //var mlsEmail = String()
    
    @IBAction func requestAuthTokenPassword(sender: AnyObject)
    {
        print("Mlsarea: \(pickerDataSource[mlsAreaPickerView!.selectedRowInComponent(0)])")
        print("email: \(mlsEmailTextField!.text!)")
        print("mlsAreaID: \(mlsAreaPickerView!.selectedRowInComponent(0)+1)")
        
        //Hardcoded requestAuth func
        //print(dataProvider.requestAuthentication("cbboyd2@gmail.com", mlsFeedID: 1))
        
        //Note that it is selected row + 1 to align the wheel index to the mls values in the databases
        
        //uncomment this to re allow authentication system - Walker
        //let authenticated = dataProvider.requestAuthentication(mlsEmailTextField!.text!, mlsFeedID: mlsAreaPickerView!.selectedRowInComponent(0)+1)
        
        let authenticated = true
        if (authenticated == true){
        //pushes to the login page
            print("Authenticated..!")
            loginButton.hidden = false
            passwordLabel.hidden = false
            passwordText.hidden = false
            loginLabel.hidden = false
            requestToken.hidden = true
            requestAuthenticationTitleLabel.hidden = true
            
       /* *     let thirdViewController: LoginPageViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("loginPageSegue") as AnyObject? as? LoginPageViewController)!
            thirdViewController.mlsEmailTextField = self.mlsEmailTextField
            thirdViewController.mlsAreaPickerView = self.mlsAreaPickerView **/
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
            print("Successfully logged-in!")
            /**if let secondViewController = self.storyboard?.instantiateInitialViewController("sw_front") as? SWRevealViewController
            {
                let nav
            }**/
            
            /**if let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("menuSegue") as? SWRevealViewController
            {
                let navController = UINavigationController(rootViewController: secondViewController)
                navController.setViewControllers([secondViewController], animated: true)
                self.revealViewController().setFrontViewController(navController, animated: true)
            }**/
            
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

