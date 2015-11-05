//
//  AddFavoriteAreasViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 11/2/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class AddFavoriteAreasViewController: UIViewController
{
    @IBOutlet weak var saveButtonLabel: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func saveButton(sender: UIBarButtonItem)
    {
        
    }

    @IBAction func cancelButton(sender: UIBarButtonItem)
    {
     dismissViewControllerAnimated(true, completion: nil)
    }
}
