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
    var timePickerView = ["Monthly", "Quarterly"]
    
    let urlPath: String = "http://localhost:9207/api/user/1?email=cbboyd2@gmail.com"
    var url: NsURL = NSURL(string: urlPath)!
    var request1: NSURLRequest = NSURLRequest(URL: url)
    var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
    var dataVal: NSData = NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
    var err: NSErrorprintln(response)
    var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary
    println("Synchronous\(jsonResult)"
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //if (mlsCityPickerView.tag == 12)
        //{
        return pickerDataSource.count;
        //}
        //else
        //{
            //return timePickerView.count;
        //}
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //if (mlsCityPickerView.tag == 12)
        //{
        return pickerDataSource[row]
        //}
        //else
        //{ return timePickerView[row]}
    }

    func numberOfComponentsInTimeReportPickerView(pickerView: UIPickerView) -> Int { return 1 }
    
    func timeReportPickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timePickerView.count;
    }

    func timeReportPickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timePickerView[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mlsCityPickerView.dataSource = self;
        self.mlsCityPickerView.delegate = self;
        self.timeReportPickerView.dataSource = self;
        self.timeReportPickerView.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
