//
//  ResourceLinksViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 10/29/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 8.0, *)
class ResourceLinksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func greaterALMLSLinkButton(sender: AnyObject)
    {
        if let greaterALMLSUrl = NSURL(string: "https://www.greateralabamamls.com")
        {
            UIApplication.sharedApplication().openURL(greaterALMLSUrl)
        }
    }
    
    @IBAction func barLinkButton(sender: AnyObject)
    {
        if let barWebUrl = NSURL (string: "http://birminghamrealtors.com")
        {
            UIApplication.sharedApplication().openURL(barWebUrl)
        }
    }
    
    @IBAction func mortgageCalcLinkButton(sender: AnyObject)
    {
        if let mortgageCalUrl = NSURL (string: "http://www.mortgagecalculator.org")
        {
            UIApplication.sharedApplication().openURL(mortgageCalUrl)
        }
    }
    
    @IBAction func acreLinkButton(sender: AnyObject)
    {
        if let acreUrl = NSURL (string: "http://acre.culverhouse.ua.edu/markets/birmingham")
        {
            UIApplication.sharedApplication().openURL(acreUrl)
        }
        
    }
    
    //functions for the table views
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResourcesTableViewCell", forIndexPath: indexPath)
        return cell
    }
    

    //delete personal links functionality -- still need to make corrections but can only do it after resource links are added into table
    /*var deleteResourcesIndexPath: NSIndexPath? = nil
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            deleteResourcesIndexPath = indexPath
            //let resourceToDelete = resources[indexPath.row] ****this resources will be where the added resources are stored (in whatever manner they are stored)
            //confirmDelete(resourceToDelete)
        }
    }
    
    func confirmDelete(areas: String)
    {
        let alert = UIAlertController(title: "Delete Personal Resource Link", message: "Are you sure you want to permanently delete this link?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteResourceLinks)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteResourceLinks)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteResourceLinks(alertAction: UIAlertAction!) -> Void
    {
        if let indexPath = deleteResourcesIndexPath
        {
            //tableView.beginUpdates()
            
            //array.removeAtIndex(indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            //deleteResourcesIndexPath = nil
            
            //tableView.endUpdates()
        }
    }
    
    func cancelDeleteResourceLinks(alertAction: UIAlertAction!) {
        deleteResourcesIndexPath = nil
    }*/
    //end of delete functionality
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResourcesTableViewCell")
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /*@IBAction func saveLinks(segue:UIStoryboardSegue)
    {
        if let addResourceLinksViewController = segue.sourceViewController as? AddResourceLinksViewController {
            print("Unwinding")
        }
    }*/
    
    
    
    
    
    
}