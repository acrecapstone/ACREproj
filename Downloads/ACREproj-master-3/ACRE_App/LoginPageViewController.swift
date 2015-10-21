//
//  LoginPageViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/8/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import UIKit
import Foundation
//import Alamofire


class LoginPageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    

    @IBOutlet weak var mlsEmailTextField: UITextField!
    @IBOutlet weak var authTokenPasswordTextField: UITextField!
    @IBOutlet weak var mlsAreaPickerView: UIPickerView!


    
    /**func isAuthenticated(email: String, password: String) -> Bool {
        if ((email == email) && (password == password))
        {
            return true
        } else
        {
            return false
        }
    }**/
    
    @available(iOS 8.0, *)
    @IBAction func signInButton(sender: AnyObject) {
        
        let email = "admin@acre.com"
        let password = "grayson"
        
        if mlsEmailTextField.text == email && authTokenPasswordTextField.text == password
        {
            let secondViewController: HomePageViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("homePageSegue") as AnyObject? as? HomePageViewController)!
            //this is used when passing data to the next view
            //secondViewController.user = self.user
            //secondViewController.pass = self.TextFieldPassword.text
            self.showViewController(secondViewController, sender: self)
            //self.performSegueWithIdentifier("homePageSegue", sender: self)
        }
        else
        {
            let alertView: UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed"
            alertView.message = "Please enter email and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            //what action do i need to take in order to stay on the login page?
        }
        
        /**let mlsEmail:NSString = mlsEmailTextField.text!
        let authToken:NSString = authTokenPasswordTextField.text!
        
        //allows login to Home Page if email and password correct from below
        if (mlsEmail.isEqualToString("") || authToken.isEqualToString("") ) {
                let alertView: UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed"
                alertView.message = "Please enter email and Password"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
        }
        else if (isAuthenticated(self.mlsEmailTextField.text!, password: self.authTokenPasswordTextField.text!))
        {
            self.performSegueWithIdentifier("homePageSegue", sender: self)
        }**/

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
        self.mlsAreaPickerView.dataSource = self;
        self.mlsAreaPickerView.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        /**var email = "admin@acre.com"
        var password = "grayson"
  

        if (isAuthenticated(self.mlsEmailTextField.text!, password: self.authTokenPasswordTextField.text!))
        {
            self.performSegueWithIdentifier("homePageSegue", sender: self)
        }
        else
        {
            verifyLabel.text = "The credentials are not correct. Try again!"
        }**/
}





