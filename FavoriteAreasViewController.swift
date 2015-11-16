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
    
    let dL = FEDataLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
        tableView.allowsMultipleSelection = false
        let acreDB = dL.createACREDB()
        let selectedIndex = indexPath.row
        
        if(indexPath.row == selectedIndex)
        {
            if (cell.accessoryType == UITableViewCellAccessoryType.None) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
            }
                
            else if (cell.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                cell.accessoryType = UITableViewCellAccessoryType.None;
            }
        }
            //cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        //}
        //else {
        //    cell.accessoryType = UITableViewCellAccessoryType.None
        //}
        
        /*if cell.selected {
            let rowIndex = indexPath.row
            let selectedArea = cellArray[rowIndex].areaID
            
            cell.selected = false
            if cell.accessoryType == UITableViewCellAccessoryType.None
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                if acreDB.open() {
                    if selectedArea != dL.getDefaultAreaID(acreDB) {
                        dL.updateDefAreaAndStat(acreDB, nDefAreaID: selectedArea)
                    }
                }
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            acreDB.close() */

        //}

        return cell
    }
    
    var checkedIndexPath : NSIndexPath?
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        tableview.reloadData()
        
        /*let cell = tableview.cellForRowAtIndexPath(indexPath)
        var choice = [Int](count: 1, repeatedValue: Int())
        tableView.allowsMultipleSelection = false
        let acreDB = dL.createACREDB()
        
        if cell!.selected
        {
            let rowIndex = indexPath.row
            let selectedArea = cellArray[rowIndex].areaID
            
            cell!.selected = false
            if cell!.accessoryType == UITableViewCellAccessoryType.None
            {
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                if acreDB.open() {
                    if selectedArea != dL.getDefaultAreaID(acreDB) {
                        dL.updateDefAreaAndStat(acreDB, nDefAreaID: selectedArea)
                    }
                }
            }
            else
            {
                cell!.accessoryType = UITableViewCellAccessoryType.None
            }

            let row = indexPath.row
            choice[0] = row
            acreDB.close() */
        
        //let acreDB = dL.createACREDB()
        /*
        if acreDB.open() {
        
        let id = choice[0]
        let querySQL = "UPDATE AREA SET isDefault = 1 WHERE areaID = \(id);"
        let results = acreDB.executeUpdate(querySQL, withArgumentsInArray:nil)
        if !results {
        print("Error: \(acreDB.lastErrorMessage())")
        }
        else{
        print("Record Updated")
        }
        acreDB.close()
        } */
        
        }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let acreDB = dL.createACREDB()
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
                acreDB.close()
            }
            
            array.removeAtIndex(indexPath.row)
            cellArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            }
    }
    
    
    
    func query() -> Array<AreaDisplayer>
    {
        var count = 0
        let acreDB = dL.createACREDB()
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
        tableview.reloadData()

    }

    
    
}

   
    





