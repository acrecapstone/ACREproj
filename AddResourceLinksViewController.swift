//
//  AddResourceLinksViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 10/29/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 8.0, *)
class AddResourceLinksViewController: UIViewController
{
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var labelTextField: UITextField!
    let dL = FEDataLayer()
    
    @IBAction func saveLinksButton(sender: AnyObject)
    {
        let url = String(linkTextField!.text)
        let label = String(labelTextField!.text)

        let acreDB = dL.createACREDB()
        
        if url == "" || label == "" {
            if (linkTextField.text!.isEmpty && labelTextField.text!.isEmpty)
            {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Please enter URL Link and Label"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else {
            if acreDB.open() {
                
                let sqlStmt = "INSERT INTO RESOURCE (url, label) VALUES ('\(url)', '\(label)');"
                let result = acreDB.executeUpdate(sqlStmt, withArgumentsInArray: nil)
                
                if !result {
                    print("Error: \(acreDB.lastErrorMessage())")
                } else {
                    print("Resource Added")
                }
                acreDB.close()
            }
            else{
                print("Error: \(acreDB.lastErrorMessage())")
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(sender: UIBarButtonItem)
    {
        var a = dL.getValidAgents()
        var b = dL.getValidAgentFeedIDs()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}