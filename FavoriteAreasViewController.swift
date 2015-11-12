//
//  FavoriteAreasViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/2/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 8.0, *)
class FavoriteAreasViewController: UITableViewController
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.tableview.setEditing(true, animated: true) --Tulsi commented this out cause it dealt with deleting the rows.
        
       if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            tableview.reloadData()
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    var array = [AreaDisplayer](count: 0, repeatedValue: AreaDisplayer())
    var cellArray = [AreaDisplayer](count: 0, repeatedValue: AreaDisplayer())
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        array = query()
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteAreasTableCell", forIndexPath: indexPath) 
        cellArray = query()
        cell.textLabel?.text = cellArray[indexPath.row].title

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
            let databasePath = fileURL.path!
            let acreDB = FMDatabase(path: databasePath as String)
            let id = cellArray[indexPath.row].areaID
            if acreDB.open()
            {
                let querySQL = "UPDATE AREA SET isFavorite = 0 WHERE areaID = \(id);"
                let result = acreDB.executeUpdate(querySQL, withArgumentsInArray:nil)
                
                if !result {
                    print("Error: \(acreDB.lastErrorMessage())")
                } else {
                    print("Updated")
                }
            }
            acreDB.close()
            
            array.removeAtIndex(indexPath.row)
            cellArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            }
    }
    
    
    func query() -> Array<AreaDisplayer>
    {
        var count = 0
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        var temp = [AreaDisplayer](count: 0, repeatedValue: AreaDisplayer())
        if acreDB.open() {
                let querySQL = "SELECT areaName, areaCode, areaID FROM AREA WHERE isFavorite = 1 ORDER BY areaCode ASC"
                let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let areaID = results?.intForColumn("areaID")
                let title = (code?.stringByAppendingString(" - " + name!))
                let dsplyr = AreaDisplayer();
                dsplyr.title = title!
                dsplyr.areaID = Int(areaID!)
                temp.append(dsplyr)
                count++
                
                print("Record Found")
            }
            acreDB.close()
            }
        return temp
        }
    
    @IBAction func saveAreas(segue:UIStoryboardSegue)
    {
        if let addFavoriteAreasViewController = segue.sourceViewController as? AddFavoriteAreasViewController
        {
            print("Unwinding")
        }

    }
}
    
    
   

   
    





