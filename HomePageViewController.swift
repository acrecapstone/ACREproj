//
//  HomePageViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/8/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import UIKit
import Foundation

class HomePageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    //variables
    @IBOutlet weak var mlsCityPickerView: UIPickerView!
    @IBOutlet weak var timeReportPickerView: UIPickerView!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var medianSalesPriceLabel: UILabel!
    @IBOutlet weak var listSellPriceLabel: UILabel!
    @IBOutlet weak var salesByUnitLabel: UILabel!
    @IBOutlet weak var salesByVolumeLabel: UILabel!
    @IBOutlet weak var domLabel: UILabel!
    @IBOutlet weak var inventoryLabel: UILabel!
    @IBOutlet weak var monthOfSupplyLabel: UILabel!
    
    //intializing the arrays for the picker
    var picker1Options = []
    var picker2Options = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        picker1Options = ["140-Trussville", "139-Hoover", "138-Birmingham"]
        picker2Options = ["Monthly", "Quarterly"]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if (pickerView.tag == 1)
        {
            return picker1Options.count
        }
        else
        {
            return picker2Options.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (pickerView.tag == 1)
        {
            return "\(picker1Options[row])"
        }
        else
        {
            return "\(picker2Options[row])"
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





//    var pickerDataSource = ["140-Trussville", "139-Hoover", "138-Birmingham"]
//
//    var pickerData: [String] = [String]()
//
//    //var timePickerView = ["Monthly", "Quarterly"]
//
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerDataSource.count;
//
//        //if (mlsCityPickerView.tag == 12)
//        //{
//        //return pickerDataSource.count;
//        //}
//        //else
//        //{
//        //return timePickerView.count;
//        //}
//    }
//
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerDataSource[row]
//
//        //if (mlsCityPickerView.tag == 12)
//        //{
//        //return pickerDataSource[row]
//        //}
//        //else
//        //{return timePickerView[row]}
//    }
//
//    func numberOfComponentsInTimeReportPickerView(pickerView: UIPickerView) -> Int { return 1 }
//
//    func timeReportPickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count;
//    }
//
//    func timeReportPickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
