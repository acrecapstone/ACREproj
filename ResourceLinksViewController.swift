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
class ResourceLinksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    let dL = FEDataLayer()
    var resourceArray = [ResourceData](count: 0, repeatedValue: ResourceData())
    var cellResourceArray = [ResourceData](count: 0, repeatedValue: ResourceData())
    
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResourcesTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    //functions for the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //resourceArray = getResources()
        //return resourceArray.count
        //return testArray.count
        //let acreDB = dL.createACREDB()
        
        //if acreDB.open()
        //{
            //let linkCount = "SELECT COUNT(resourceID) FROM RESOURCE"
            //let link = Int(acreDB.intForQuery(linkCount))

            //print("\(link)")
            
            //acreDB.close()
        
        resourceArray = getResources()
        return resourceArray.count
        //}
        //else
        //{
        //    print("Error: \(acreDB.lastErrorMessage())")
        //    return -1
        //}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResourcesTableViewCell", forIndexPath: indexPath) as UITableViewCell
        cellResourceArray = getResources()
        cell.textLabel?.text = cellResourceArray[indexPath.row].label
        
        return cell
    }
    
    //var resourceArray = [ResourceData](count: 0, repeatedValue: ResourceData())
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            let acreDB = dL.createACREDB()
            let id = cellResourceArray[indexPath.row].resourceID
            if acreDB.open()
            {
                let querySQL = "DELETE FROM RESOURCE WHERE resourceID = \(id);"
                let result = acreDB.executeUpdate(querySQL, withArgumentsInArray: nil)
                
                if !result {
                    print("Error: \(acreDB.lastErrorMessage())")
                } else {
                    print("Resource Deleted")
                }
                acreDB.close()
            }
            
            resourceArray.removeAtIndex(indexPath.row)
            cellResourceArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let acreDB = dL.createACREDB()
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        acreDB.open()
        let linkQuery = "SELECT url FROM RESOURCE"
        let results: FMResultSet? = acreDB.executeQuery(linkQuery, withArgumentsInArray: nil)
        
        let urlLink = results?.stringForColumn("url")
        let convertedLink = NSURL(string: "https://\(urlLink)")
        
        if cell!.selected
        {
            if let convertedLink = NSURL(string: "http://\(urlLink)")
            {
                UIApplication.sharedApplication().openURL(convertedLink)
            }
        }
        acreDB.close()

        /*let cell = tableView.cellForRowAtIndexPath(indexPath)
        let urlLink = String()
        let convertedLink = NSURL(string: "http://\(urlLink)")
        
        if cell!.selected
        {
            UIApplication.sharedApplication().openURL(convertedLink!)
        }*/

        
        //let convertedLink = NSMutableAttributedString(string:personalLabel, attributes:[NSLinkAttributeName: NSURL(string: "http//\(urlLink)")!])
        /*if cell!.selected
        {
            UIApplication.sharedApplication().openURL(urlLink)
        }*/

    }
    
    func passArray() -> Array<ResourceData>
    {
        return resourceArray
    }
    
    func getResources() -> Array<ResourceData>
    {
        var count = 0
        let acreDB = dL.createACREDB()
        var resources = [ResourceData](count: 0, repeatedValue: ResourceData())
        
        if acreDB.open()
        {
            let querySQL = "SELECT label, url, resourceID FROM RESOURCE;"
            let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true
            {
                let label = results?.stringForColumn("label")
                let url = results?.stringForColumn("url")
                let resourceID = results?.intForColumn("resourceID")
                //let convertedLink = NSURL(string: "http://\(urlLink)")
                //let convertedLink = NSMutableAttributedString(string:personalLabel!, attributes:[NSLinkAttributeName: NSURL(string: "http//\(urlLink)")!])
                let resource = ResourceData();
                resource.label = label!
                resource.url = url!
                resource.resourceID = Int(resourceID!)
                //resource.convertedLink = NSURL()
                resources.append(resource)
                count++
            }
            acreDB.close()
            
        }
        else
        {
            print("Error: \(acreDB.lastErrorMessage())")
        }
        
        return resources
        
    }
}

    /*@IBAction func saveLinks(segue:UIStoryboardSegue)
    {
        if let addResourceLinksViewController = segue.sourceViewController as? AddResourceLinksViewController {
            print("Unwinding")
        }
        tableView.reloadData()
    }*/


