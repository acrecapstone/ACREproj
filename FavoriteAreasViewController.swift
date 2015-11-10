//
//  FavoriteAreasViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/2/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class FavoriteAreasViewController: UITableViewController
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableview.setEditing(true, animated: true)
        
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let array = query()
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteAreasTableCell", forIndexPath: indexPath) as! UITableViewCell
        let areas = query()
        cell.textLabel?.text = areas[indexPath.row].title

        return cell
    }
    
    var array = [AreaDisplayer](count: 0, repeatedValue: AreaDisplayer())
    var count = 0
    
    func query() -> Array<AreaDisplayer>
    {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
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
                array.append(dsplyr)
                count++
                
                print("Record Found")
                
            }
            acreDB.close()
            }
        return array
        }
    
    @IBAction func saveAreas(segue:UIStoryboardSegue)
    {
        if let addFavoriteAreasViewController = segue.sourceViewController as? AddFavoriteAreasViewController {
            tableview.reloadData()
            print("Unwinding")
        }
    }
    
    
    
    }
    
    
   

   
    





