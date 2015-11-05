//
//  ResourceLinksViewController.swift
//  ACRE_App
//
//  Created by Sonaa  on 10/29/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class ResourceLinksViewController: UIViewController
{
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
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
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
    
}