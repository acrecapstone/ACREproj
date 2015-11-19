//
//  ManageDefaultViewController.swift
//  ACRE_App
//
//  Created by MacMini1 on 11/18/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class ManageDefaultViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSURLConnectionDataDelegate
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var defaultAreaPickerView: UIPickerView!
    @IBOutlet weak var defaultReportingPickerView: UIPickerView!
    
    let dL = FEDataLayer()
    var areaPicker = [AreaDisplayer]()
    var reportingPicker = []
    
    
    override func viewDidLoad() {
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let acreDB = dL.createACREDB()
        
        if acreDB.open() {
            areaPicker = dL.getAreas()
            acreDB.close()
            reportingPicker = ["Monthly", "Quarterly"]
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }

        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
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
    
    /*
    //Walker Did this, may be useless
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component : Int) -> Int {
        if (pickerView.isEqual(defaultAreaPickerView)) {
            return dL.getAreas().count
        }
        else if (pickerView.isEqual(defaultReportingPickerView)) {
            return 2
        }
    
        return 0
    }*/
    
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
        
        if pickerView.isEqual(defaultAreaPickerView) {
            let areaID = areaPicker[defaultReportingPickerView!.selectedRowInComponent(0)].areaID
            
        }
        else if pickerView.isEqual(defaultReportingPickerView) {
    
            
        }
        //dL.updateDefAreaAndStat(areaID, timePref: timePref)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}