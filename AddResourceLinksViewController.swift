//
//  AddResourceLinksViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 10/29/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class AddResourceLinksViewController: UIViewController
{
    
    @IBAction func cancel(sender: UIBarButtonItem)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var labelTextField: UITextField!
    
    
    
    
    @IBAction func saveLinksButton(sender: AnyObject)
    {
        let url = linkTextField!.text
        let label = labelTextField!.text
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
            
            let sqlStmt = "INSERT INTO RESOURCE (url, label) VALUES ('\(url)', '\(label)');"
            let result = acreDB.executeUpdate(sqlStmt, withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Resource Added")
            }

        }
        acreDB.close()
        
        if (linkTextField.text!.isEmpty && labelTextField.text!.isEmpty)
        {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Please enter URL Link and Label"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        /*else
        {
            performSegueWithIdentifier("saveLinks", sender: self)
        }*/
    }
    
    override func viewDidLoad()
    {
        
        //self.linkTextField!.delegate = self
        //self.labelTextField!.delegate = self
    }
    
    
}