//
//  AddFavoriteAreasViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/2/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class AddFavoriteAreasViewController: UITableViewController
{
    @IBOutlet weak var saveButtonLabel: UIBarButtonItem!
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "AddFavoriteAreasTableCell")
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("addFavoriteAreas", forIndexPath: indexPath) as! AddFavoriteAreasViewCell
        /*let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
            
            let querySQL = "SELECT areaName, areaCode FROM AREA ORDER BY areaCode ASC"
            let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
            let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            
            var count = 0
            let cap = Int(acreDB.intForQuery(areaCount))
            var temp = [String](count: cap, repeatedValue: String())
            
            while results?.next() == true {
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let title = (code?.stringByAppendingString(" - " + name!))
                
                temp[count] = title!
                count++
                
                print("Record Found")
                
            }
            //cell.textLabel?.text = temp[indexPath.item]
            acreDB.close()
            
            for x in temp {
                print(x)
            }
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        } */
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    

    @IBAction func saveButton(sender: UIBarButtonItem)
    {
        //Use this to implement the delete function
        //self.tableview.setEditing(true, animated: true)
        //tableview.allowsMultipleSelection = true
        self.performSegueWithIdentifier("Save", sender: sender)
    }
    
    override func prepareForSegue ( segue: UIStoryboardSegue, sender: AnyObject!) {
        /*if (segue.identifier == "Save") {
            let destination = segue.destinationViewController as! FavoriteAreasViewController
            let cell = sender as! UITableViewCell
            let selectedRow = tableView.indexPathForCell(cell)!.row
            destination.selectedRow = array[selectedRow]  */
            
            //svc.toPass = self.force
            //svc.toPass2 = stiffness
            
        //}
        
        
    }

    @IBAction func cancelButton(sender: UIBarButtonItem)
    {
     dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
        
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
            let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            let cap = Int(acreDB.intForQuery(areaCount))
            
            acreDB.close()
            
            return cap //should be return whatever.count
            
        } else {
            print("Error: \(acreDB.lastErrorMessage())")
            
            return -1
        }
    }
    
    var count = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AddFavoriteAreasTableCell", forIndexPath: indexPath) as! UITableViewCell
        var areas = getAreas()
        cell.textLabel?.text = areas[indexPath.row]
        
        if cell.selected
        {
            
            cell.selected = false
            if cell.accessoryType == UITableViewCellAccessoryType.None
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
            
        }
        
        return cell
    }
    
    
    var array = [String](count: 0, repeatedValue: String())
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableview.cellForRowAtIndexPath(indexPath)
        
       
        if cell!.selected
        {
            cell!.selected = false
            if cell!.accessoryType == UITableViewCellAccessoryType.None
            {
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
              
            }
            else
            {
                cell!.accessoryType = UITableViewCellAccessoryType.None
            }
            array.append((cell!.textLabel?.text)!)
            
            
        }
    }
    
    /*func createArray(count: Int) -> Array<String>
    {
        let array = [String](count: count, repeatedValue: String())
        return array
    } */
    
    
    func getAreas() -> Array<String>
    {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        var array = []
        
        if acreDB.open() {
            
            let querySQL = "SELECT areaName, areaCode FROM AREA ORDER BY areaCode ASC"
            let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
            let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            
            var count = 0
            let cap = Int(acreDB.intForQuery(areaCount))
            var temp = [String](count: cap, repeatedValue: String())
            
            while results?.next() == true {
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let title = (code?.stringByAppendingString(" - " + name!))
                
                temp[count] = title!
                count++
                
                print("Record Found")
                
            }
            acreDB.close()
            array = temp
            for x in temp {
                print(x)
            }
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }

        return array as! Array<String>
    }
    
}
