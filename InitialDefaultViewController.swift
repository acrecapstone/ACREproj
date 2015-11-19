//
//  InitialDefaultViewController.swift
//  ACRE_App
//
//  Created by MacMini1 on 11/18/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class InitialDefaultViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSURLConnectionDataDelegate
{
    @IBOutlet weak var initialDefaultAreaPickerView: UIPickerView!
    
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var initialDefaultReportingPickerView: UIPickerView!
    
    let dL = FEDataLayer()
    var areaPicker = [AreaDisplayer]()
    let reportingPicker = ["Monthly", "Quarterly"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let acreDB = dL.createACREDB()
        if acreDB.open() {
            areaPicker = dL.getAreas()
            acreDB.close()
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func setButton(sender: AnyObject)
    {
        //set defaults
        //get stats for default page and store stats
        
        let secondViewController: SWRevealViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("menuSegue") as AnyObject? as? SWRevealViewController)!
        self.showViewController(secondViewController, sender: self)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if (pickerView.tag == 1)
        {
            return areaPicker.count
        }
        else
        {
            return reportingPicker.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (pickerView.tag == 1)
        {
            return "\(areaPicker[row].title)"
        }
        else
        {
            return "\(reportingPicker[row])"
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var areaID: Int
        var timePref: Int
        
        if pickerView.isEqual(initialDefaultAreaPickerView) {
            let areaID = areaPicker[initialDefaultReportingPickerView!.selectedRowInComponent(0)].areaID
            
        }
        else if pickerView.isEqual(initialDefaultReportingPickerView) {
            let time = reportingPicker[initialDefaultReportingPickerView!.selectedRowInComponent(0)]
            if time as! String == "Monthly" {
                let timePref = 1
            }
            else if time as! String == "Quarterly" {
                let timePref = 0
            }

        }
        //dL.updateDefAreaAndStat(areaID, timePref: timePref)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}