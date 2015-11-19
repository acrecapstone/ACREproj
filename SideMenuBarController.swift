//
//  SideMenuBarController.swift
//  ACRE_App
//
//  Created by Sonaa  on 10/29/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class SideMenuBarController: UITableViewController
{
    @IBOutlet weak var homeSideMenuLabel: UILabel!
    @IBOutlet weak var manageAreasSideMenuLabel: UILabel!
    @IBOutlet weak var viewAddLeadsSideMenuLabel: UILabel!
    @IBOutlet weak var resourcesSideMenuLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5 //should be return whatever.count
    }
    
    
    /**override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let homeTableView = "homeViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(homeTableView, forIndexPath: indexPath) as! HomeViewTableCell
        
        let manageAreasTableView = "manageAreasViewCell"
        let cell2 = tableView.dequeueReusableCellWithIdentifier(manageAreasTableView, forIndexPath: indexPath) as! ManageAreasTableViewCell
        
        let viewLeadsTableView = "viewLeadsViewCell"
        let cell3 = tableView.dequeueReusableCellWithIdentifier(viewLeadsTableView, forIndexPath: indexPath) as! ViewLeadsTableViewCell
        
        let resourceTableView = "resourceViewCell"
        let cell4 = tableView.dequeueReusableCellWithIdentifier(resourceTableView, forIndexPath: indexPath) as! ResourcesViewTableCell
        
        
        
        // Fetches the appropriate meal for the data source layout.
        //let meal = meals[indexPath.row]
        
        //cell.nameLabel.text = meal.name
        
        return cell
    }**/
}