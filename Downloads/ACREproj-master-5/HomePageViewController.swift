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
    
    var pickerDataSource = ["140-Trussville", "139-Hoover", "138-Birmingham"]
    
    var pickerData: [String] = [String]()
    
    //var timePickerView = ["Monthly", "Quarterly"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
        
        //if (mlsCityPickerView.tag == 12)
        //{
        //return pickerDataSource.count;
        //}
        //else
        //{
        //return timePickerView.count;
        //}
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
        
        //if (mlsCityPickerView.tag == 12)
        //{
        //return pickerDataSource[row]
        //}
        //else
        //{return timePickerView[row]}
    }

    func numberOfComponentsInTimeReportPickerView(pickerView: UIPickerView) -> Int { return 1 }
    
    func timeReportPickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }

    func timeReportPickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mlsCityPickerView.dataSource = self;
        self.mlsCityPickerView.delegate = self;
        self.timeReportPickerView.dataSource = self;
        self.timeReportPickerView.delegate = self;
        
    
        pickerData = ["Monthly", "Quarterly"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
}
