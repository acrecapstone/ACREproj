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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
        return 1 //should be return whatever.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let favoriteAreaIdentifier = "FavoriteAreasTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(favoriteAreaIdentifier, forIndexPath: indexPath) as! FavoriteAreasTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        //let meal = meals[indexPath.row]
        
        //cell.nameLabel.text = meal.name

        return cell
    }
}




