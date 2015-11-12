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
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    

    @IBAction func saveButton(sender: UIBarButtonItem)
    {
        
        performSegueWithIdentifier("saveAreas", sender: self)

    }
    

    @IBAction func cancelButton(sender: UIBarButtonItem)
    {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
            let sql = "CREATE TABLE STATS (statsID INTEGER PRIMARY KEY AUTOINCREMENT, areaID INTEGER, isDefault BOOL, isMonthly BOOL, timestamp DATETIME, month TEXT, day INTEGER, year TEXT, medPrice DECIMAL(10, 1), medPricePrev DECIMAL(10, 1), medPriceMth DECIMAL(10, 1), medPriceQtr DECIMAL(10, 1), medPricePerc DECIMAL(10, 1), listSell DECIMAL(10, 1), listSellPrev DECIMAL(10, 1), listSellMth DECIMAL(10, 1), listSellQtr DECIMAL(10, 1), listSellPerc DECIMAL(10, 1), unitSales INTEGER, unitSalesPrev INTEGER, unitSalesMth INTEGER, unitSalesQtr INTEGER, unitSalesPerc DECIMAL(10, 1), volSales INTEGER, volSalesPrev INTEGER, volSalesMth INTEGER, volSalesQtr INTEGER, volSalesPerc DECIMAL(10, 1), dom INTEGER, domPrev INTEGER, domMth INTEGER, domQtr INTEGER, domPerc DECIMAL(10, 1), inv INTEGER, invPRev INTEGER, invMth INTEGER, invQtr INTEGER, invPerc DECIMAL(10, 1), mos DECIMAL(10, 1), mosPrev DECIMAL(10, 1), mosMth DECIMAL(10, 1), mosQtr DECIMAL(10, 1), mosPerc DECIMAL(10, 1))"
            let results = acreDB.executeStatements(sql)
            if !results {
                print("Error: \(acreDB.lastErrorMessage())")
            }
            else{
                print("Table Created")
            }
            
        }
        acreDB.close()

        
        
        
        
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
            //let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            let cap = Int(acreDB.intForQuery(areaCount))
            
            acreDB.close()
            
            return cap
            
        } else {
            print("Error: \(acreDB.lastErrorMessage())")
            
            return -1
        }
    }
    
    var count = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AddFavoriteAreasTableCell", forIndexPath: indexPath) 
        var areas = getAreas()
        cell.textLabel?.text = areas[indexPath.row].title
        
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
    
    
    var array = [AreaDisplayer](count: 0, repeatedValue: AreaDisplayer())
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableview.cellForRowAtIndexPath(indexPath)
        var choice = [Int](count: 0, repeatedValue: Int())
       
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
            var row = indexPath.row
            row++
            choice.append(row)

        }
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
            let databasePath = fileURL.path!
            let acreDB = FMDatabase(path: databasePath as String)
            
            if acreDB.open() {
                var i = 0
                for _ in choice {
                    let id = choice[i]
                    let querySQL = "UPDATE AREA SET isFavorite = 1 WHERE areaID = \(id);"
                    let results = acreDB.executeUpdate(querySQL, withArgumentsInArray:nil)
                    if !results {
                        print("Error: \(acreDB.lastErrorMessage())")
                    }
                    else{
                        print("Record Updated")
                    }
                    
                    i++
                }
                
            }
        acreDB.close()
            
        
    }
    
   func passArray() -> Array<AreaDisplayer>
   {
    return array 
    }
    
    
    func getAreas() -> Array<AreaDisplayer>
    {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        var array = []
        
        if acreDB.open() {
            
            let querySQL = "SELECT areaName, areaCode, areaID FROM AREA;"
            let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
            //let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            
            var count = 0
            let cap = Int(acreDB.intForQuery(areaCount))
            var temp = [AreaDisplayer](count: cap, repeatedValue: AreaDisplayer())
            
            while results?.next() == true {
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let areaID = results?.intForColumn("areaID")
                let title = (code?.stringByAppendingString(" - " + name!))
                let dsplyr = AreaDisplayer();
                dsplyr.title = title!
                dsplyr.areaID = Int(areaID!)
                temp[count] = dsplyr
                count++
                
                print("Record Found")
                
            }
            acreDB.close()
            array = temp
            
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }

        return array as! Array<AreaDisplayer>
    }
}
    
    
    

