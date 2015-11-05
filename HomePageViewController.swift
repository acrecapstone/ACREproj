//
//  HomePageViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/8/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import UIKit
import Foundation

class HomePageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, NSURLConnectionDataDelegate
{
    @IBOutlet weak var navigationBar: UINavigationItem!
    //variables
    @IBOutlet weak var mlsCityPickerView: UIPickerView!
    @IBOutlet weak var timeReportPickerView: UIPickerView!
    @IBOutlet weak var reportLabel: UILabel! = nil
    @IBOutlet weak var refreshButtonLabel: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    //Price Indicator Labels
    @IBOutlet weak var medianPrice: UILabel!
    @IBOutlet weak var medianPricePrevious: UILabel!
    @IBOutlet weak var listToSalesRatio: UILabel!
    @IBOutlet weak var listToSalesRatioPrevious: UILabel!
    
    //Demand Indicator Labels
    @IBOutlet weak var unitSales: UILabel!
    @IBOutlet weak var unitSalesPrevious: UILabel!
    @IBOutlet weak var volumeSales: UILabel!
    @IBOutlet weak var volumeSalesPrevious: UILabel!
    @IBOutlet weak var dom: UILabel!
    @IBOutlet weak var domPrevious: UILabel!

    //Supply Indicator Labels
    @IBOutlet weak var inventory: UILabel!
    @IBOutlet weak var inventoryPrevious: UILabel!
    @IBOutlet weak var monthOfSupply: UILabel!
    @IBOutlet weak var monthOfSupplyPrevious: UILabel!
    
    var hD : HomeData = HomeData()
    var lbDate : LabelDate = LabelDate()
    
    //intializing the arrays for the picker
    var picker1Options = []
    var picker2Options = []
    
    let dataProvider = DataProvider()
    
    @IBAction func GoButton(sender: AnyObject) {
        //let hD = dataProvider.requestHomeData(mlsCityPickerView!.selectedRowInComponent(0)+1)
        hD = dataProvider.requestHomeData(3)
        
        
        //Insert Statements
        /*
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
            let insertSQL = "INSERT INTO AGENT (authToken, agentEmail, lastLogin, mlsFeedID) VALUES ('1234abcd', 'test@email.com', '2014-7-13', 1);"
            let result = acreDB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Data1 Added")
            }
            
            let insert2 = "INSERT INTO LEAD (agentID, leadName, leadEmail, leadPhone,leadArea, leadNotes, isType) VALUES (1, 'Grayson', 'test@email.com', '2059086787', 'Birmingham', 'notes', 1);"
            let result2 = acreDB.executeUpdate(insert2, withArgumentsInArray: nil)
            
            if !result2 {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Data2 Added")
            }
            
            let insert3 = "INSERT INTO MLSFEED (feedName, agentEmail, lastLogin) VALUES ('Birmingham', 'test@email.com', '2014-7-13');"
            
            let result3 = acreDB.executeUpdate(insert3, withArgumentsInArray: nil)
            
            if !result3 {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Data3 Added")
            }
            
            let insert4 = "INSERT INTO AREA (areaCode, areaName, isFavorite) VALUES (150, 'Vestavia', 1);"
            
            let result4 = acreDB.executeUpdate(insert4, withArgumentsInArray: nil)
            
            if !result4 {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Data4 Added")
            }
            
            let insert5 = "INSERT INTO VERSION (dateUpdated, notes) VALUES ('2014-7-13', 'first update');"
            
            let result5 = acreDB.executeUpdate(insert5, withArgumentsInArray: nil)
            
            if !result5 {
                print("Error: \(acreDB.lastErrorMessage())")
            } else {
                print("Data5 Added")
            }
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }
        
        */
        
        /////////////////////////////////////////////////////////////////////////////////////////
        
        medianPrice.textColor = UIColor.blackColor()
        listToSalesRatio.textColor = UIColor.blackColor()
        unitSales.textColor = UIColor.blackColor()
        volumeSales.textColor = UIColor.blackColor()
        dom.textColor = UIColor.blackColor()
        inventory.textColor = UIColor.blackColor()
        monthOfSupply.textColor = UIColor.blackColor()
        
        if timeReportPickerView.selectedRowInComponent(0) == 0
        {
            if hD.mthMedianPPerc > 0 {
                medianPrice.textColor = UIColor.greenColor()
            }
            else if hD.mthMedianPPerc < 0 {
                medianPrice.textColor = UIColor.redColor()
            }
            if hD.mthListSellPerc > 0 {
                listToSalesRatio.textColor = UIColor.greenColor()
            }
            else if hD.mthListSellPerc < 0 {
                listToSalesRatio.textColor = UIColor.redColor()
            }
            if hD.mthMOSPerc > 0 {
                monthOfSupply.textColor = UIColor.greenColor()
            }
            else if hD.mthMOSPerc < 0 {
                monthOfSupply.textColor = UIColor.redColor()
            }
            if hD.mthUnitSalesPerc > 0 {
                unitSales.textColor = UIColor.greenColor()
            }
            else if hD.mthUnitSalesPerc < 0 {
                unitSales.textColor = UIColor.redColor()
            }
            if hD.mthVolumeSalesPerc > 0 {
                volumeSales.textColor = UIColor.greenColor()
            }
            else if hD.mthVolumeSalesPerc < 0 {
                volumeSales.textColor = UIColor.redColor()
            }
            if hD.mthDOMPerc > 0 {
                dom.textColor = UIColor.greenColor()
            }
            else if hD.mthDOMPerc < 0 {
                dom.textColor = UIColor.redColor()
            }
            if hD.mthInvPerc > 0 {
                inventory.textColor = UIColor.greenColor()
            }
            else if hD.mthInvPerc < 0 {
                inventory.textColor = UIColor.redColor()
            }
            
            medianPrice.text = String(format: "%.1f%%", hD.mthMedianPPerc * 100)
            medianPricePrevious.text = String(format: "($%.0f vs $%.0f)", hD.medianP, hD.medianPPrev)
            listToSalesRatio.text = String(format: "%.1f%%", hD.mthListSellPerc * 100)
            listToSalesRatioPrevious.text = String(format: "(%.1f%% vs %.1f%%)", hD.listSell*100, hD.listSellPrev*100)
        
            unitSales.text = String(format: "%.1f%%", hD.mthUnitSalesPerc*100)
            unitSalesPrevious.text = String(format: "(%i vs %i)",hD.unitSales, hD.unitSalesPrev)
            volumeSales.text = String(format: "%.1f%%", hD.mthVolumeSalesPerc*100)
            volumeSalesPrevious.text = String(format: "(%i vs %i)",hD.volumeSales, hD.volumeSalesPrev)
            dom.text = String(format: "%.1f%%", hD.mthDOMPerc*100)
            domPrevious.text = String(format: "(%i vs %i)",hD.dOM, hD.dOMPrev)
        
            inventory.text = String(format: "%.1f%%", hD.mthInvPerc*100)
            inventoryPrevious.text = String(format: "(%i vs %i)", hD.inv, hD.invPrev)
            monthOfSupply.text = String(format: "%.1f%%", hD.mthMOSPerc*100)
            monthOfSupplyPrevious.text = String(format: "(%.1f vs %.1f)", hD.mOS, hD.mOSPrev)
        }
        else
        {
            if hD.qtrMedianPPerc > 0 {
                medianPrice.textColor = UIColor.greenColor()
            }
            else if hD.qtrMedianPPerc < 0 {
                medianPrice.textColor = UIColor.redColor()
            }
            if hD.qtrListSellPerc > 0 {
                listToSalesRatio.textColor = UIColor.greenColor()
            }
            else if hD.qtrListSellPerc < 0 {
                listToSalesRatio.textColor = UIColor.redColor()
            }
            if hD.qtrMOSPerc > 0 {
                monthOfSupply.textColor = UIColor.greenColor()
            }
            else if hD.qtrMOSPerc < 0 {
                monthOfSupply.textColor = UIColor.redColor()
            }
            if hD.qtrUnitSalesPerc > 0 {
                unitSales.textColor = UIColor.greenColor()
            }
            else if hD.qtrUnitSalesPerc < 0 {
                unitSales.textColor = UIColor.redColor()
            }
            if hD.qtrVolumeSalesPerc > 0 {
                volumeSales.textColor = UIColor.greenColor()
            }
            else if hD.qtrVolumeSalesPerc < 0 {
                volumeSales.textColor = UIColor.redColor()
            }
            if hD.qtrDOMPerc > 0 {
                dom.textColor = UIColor.greenColor()
            }
            else if hD.qtrDOMPerc < 0 {
                dom.textColor = UIColor.redColor()
            }
            if hD.qtrInvPerc > 0 {
                inventory.textColor = UIColor.greenColor()
            }
            else if hD.qtrInvPerc < 0 {
                inventory.textColor = UIColor.redColor()
            }

            medianPrice.text = String(format: "%.1f%%", hD.qtrMedianPPerc*100)
            medianPricePrevious.text = String(format: "($%.0f vs $%.0f)", hD.medianP, hD.medianPPrev)
            listToSalesRatio.text = String(format: "%.1f%%", hD.qtrListSellPerc*100)
            listToSalesRatioPrevious.text = String(format: "(%.1f%% vs %.1f%%)", hD.listSell*100, hD.listSellPrev*100)
    
            unitSales.text = String(format: "%.1f%%", hD.qtrUnitSalesPerc*100)
            unitSalesPrevious.text = String(format: "(%i vs %i)", hD.unitSales, hD.unitSalesPrev)
            volumeSales.text = String(format: "%.1f%%", hD.qtrVolumeSalesPerc*100)
            volumeSalesPrevious.text = String(format: "(%i vs %i)", hD.volumeSales, hD.volumeSalesPrev)
            dom.text = String(format: "%.1f%%", hD.qtrDOMPerc*100)
            domPrevious.text = String(format: "(%i vs %i)", hD.dOM, hD.dOMPrev)
    
            inventory.text = String(format: "%.1f%%", hD.qtrInvPerc*100)
            inventoryPrevious.text = String(format: "(%i vs %i)", hD.inv, hD.invPrev)
            monthOfSupply.text = String(format: "%.1f%%", hD.qtrMOSPerc*100)
            monthOfSupplyPrevious.text = String(format: "(%.1f vs %.1f)", hD.mOS, hD.mOSPrev)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if revealViewController() != nil
        {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        let acreDB = FMDatabase(path: databasePath as String)
        
        if acreDB.open() {
            
            let querySQL = "SELECT areaName, areaCode FROM AREA ORDER BY areaCode ASC"
            let results: FMResultSet? = acreDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
            let capacity: FMResultSet? = acreDB.executeQuery(areaCount, withArgumentsInArray: nil)
            
            var count = 0
            let cap = Int(acreDB.intForQuery(areaCount))
            var temp = [String](count: cap, repeatedValue: String())
            
            while results?.next() == true {
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let title = (code?.stringByAppendingString(" - " + name!))
                
                temp[count] = title!
                count++
                
                print("Record Found")
                
            }
            
            acreDB.close()
            
            picker1Options = temp
            picker2Options = ["Monthly", "Quarterly"]
            
            for x in temp {
                print(x)
            }
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }
        
        //hD = Pull Default area from SQLite
        //if defaultTimePrefMth {
            //reportLabel.text = String(picker2Options[row]) + " - " + hD.month + " " + hD.year
        //}
        //else {
            //reportLabel.text = String(picker2Options[row]) + " - Quarter " + hD.quarter + " for " + hD.year
        //}
        
        var displayMth : Bool
        displayMth = true
        
        medianPrice.textColor = UIColor.blackColor()
        listToSalesRatio.textColor = UIColor.blackColor()
        unitSales.textColor = UIColor.blackColor()
        volumeSales.textColor = UIColor.blackColor()
        dom.textColor = UIColor.blackColor()
        inventory.textColor = UIColor.blackColor()
        monthOfSupply.textColor = UIColor.blackColor()
        
        // displayMth = pull default view from SQLite
        if displayMth
        {
            if hD.mthMedianPPerc > 0 {
                medianPrice.textColor = UIColor.greenColor()
            }
            else if hD.mthMedianPPerc < 0 {
                medianPrice.textColor = UIColor.redColor()
            }
            if hD.mthListSellPerc > 0 {
                listToSalesRatio.textColor = UIColor.greenColor()
            }
            else if hD.mthListSellPerc < 0 {
                listToSalesRatio.textColor = UIColor.redColor()
            }
            if hD.mthMOSPerc > 0 {
                monthOfSupply.textColor = UIColor.greenColor()
            }
            else if hD.mthMOSPerc < 0 {
                monthOfSupply.textColor = UIColor.redColor()
            }
            if hD.mthUnitSalesPerc > 0 {
                unitSales.textColor = UIColor.greenColor()
            }
            else if hD.mthUnitSalesPerc < 0 {
                unitSales.textColor = UIColor.redColor()
            }
            if hD.mthVolumeSalesPerc > 0 {
                volumeSales.textColor = UIColor.greenColor()
            }
            else if hD.mthVolumeSalesPerc < 0 {
                volumeSales.textColor = UIColor.redColor()
            }
            if hD.mthDOMPerc > 0 {
                dom.textColor = UIColor.greenColor()
            }
            else if hD.mthDOMPerc < 0 {
                dom.textColor = UIColor.redColor()
            }
            if hD.mthInvPerc > 0 {
                inventory.textColor = UIColor.greenColor()
            }
            else if hD.mthInvPerc < 0 {
                inventory.textColor = UIColor.redColor()
            }
            
            medianPrice.text = String(format: "%.1f%%", hD.mthMedianPPerc * 100)
            medianPricePrevious.text = String(format: "($%.0f vs $%.0f)", hD.medianP, hD.medianPPrev)
            listToSalesRatio.text = String(format: "%.1f%%", hD.mthListSellPerc * 100)
            listToSalesRatioPrevious.text = String(format: "(%.1f%% vs %.1f%%)", hD.listSell*100, hD.listSellPrev*100)
            
            unitSales.text = String(format: "%.1f%%", hD.mthUnitSalesPerc*100)
            unitSalesPrevious.text = String(format: "(%i vs %i)",hD.unitSales, hD.unitSalesPrev)
            volumeSales.text = String(format: "%.1f%%", hD.mthVolumeSalesPerc*100)
            volumeSalesPrevious.text = String(format: "(%i vs %i)",hD.volumeSales, hD.volumeSalesPrev)
            dom.text = String(format: "%.1f%%", hD.mthDOMPerc*100)
            domPrevious.text = String(format: "(%i vs %i)",hD.dOM, hD.dOMPrev)
            
            inventory.text = String(format: "%.1f%%", hD.mthInvPerc*100)
            inventoryPrevious.text = String(format: "(%i vs %i)", hD.inv, hD.invPrev)
            monthOfSupply.text = String(format: "%.1f%%", hD.mthMOSPerc*100)
            monthOfSupplyPrevious.text = String(format: "(%.1f vs %.1f)", hD.mOS, hD.mOSPrev)
        }
        else
        {
            if hD.qtrMedianPPerc > 0 {
                medianPrice.textColor = UIColor.greenColor()
            }
            else if hD.qtrMedianPPerc < 0 {
                medianPrice.textColor = UIColor.redColor()
            }
            if hD.qtrListSellPerc > 0 {
                listToSalesRatio.textColor = UIColor.greenColor()
            }
            else if hD.qtrListSellPerc < 0 {
                listToSalesRatio.textColor = UIColor.redColor()
            }
            if hD.qtrMOSPerc > 0 {
                monthOfSupply.textColor = UIColor.greenColor()
            }
            else if hD.qtrMOSPerc < 0 {
                monthOfSupply.textColor = UIColor.redColor()
            }
            if hD.qtrUnitSalesPerc > 0 {
                unitSales.textColor = UIColor.greenColor()
            }
            else if hD.qtrUnitSalesPerc < 0 {
                unitSales.textColor = UIColor.redColor()
            }
            if hD.qtrVolumeSalesPerc > 0 {
                volumeSales.textColor = UIColor.greenColor()
            }
            else if hD.qtrVolumeSalesPerc < 0 {
                volumeSales.textColor = UIColor.redColor()
            }
            if hD.qtrDOMPerc > 0 {
                dom.textColor = UIColor.greenColor()
            }
            else if hD.qtrDOMPerc < 0 {
                dom.textColor = UIColor.redColor()
            }
            if hD.qtrInvPerc > 0 {
                inventory.textColor = UIColor.greenColor()
            }
            else if hD.qtrInvPerc < 0 {
                inventory.textColor = UIColor.redColor()
            }
            
            medianPrice.text = String(format: "%.1f%%", hD.qtrMedianPPerc*100)
            medianPricePrevious.text = String(format: "($%.0f vs $%.0f)", hD.medianP, hD.medianPPrev)
            listToSalesRatio.text = String(format: "%.1f%%", hD.qtrListSellPerc*100)
            listToSalesRatioPrevious.text = String(format: "(%.1f%% vs %.1f%%)", hD.listSell*100, hD.listSellPrev*100)
            
            unitSales.text = String(format: "%.1f%%", hD.qtrUnitSalesPerc*100)
            unitSalesPrevious.text = String(format: "(%i vs %i)", hD.unitSales, hD.unitSalesPrev)
            volumeSales.text = String(format: "%.1f%%", hD.qtrVolumeSalesPerc*100)
            volumeSalesPrevious.text = String(format: "(%i vs %i)", hD.volumeSales, hD.volumeSalesPrev)
            dom.text = String(format: "%.1f%%", hD.qtrDOMPerc*100)
            domPrevious.text = String(format: "(%i vs %i)", hD.dOM, hD.dOMPrev)
            
            inventory.text = String(format: "%.1f%%", hD.qtrInvPerc*100)
            inventoryPrevious.text = String(format: "(%i vs %i)", hD.inv, hD.invPrev)
            monthOfSupply.text = String(format: "%.1f%%", hD.qtrMOSPerc*100)
            monthOfSupplyPrevious.text = String(format: "(%.1f vs %.1f)", hD.mOS, hD.mOSPrev)
        }
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if timeReportPickerView.selectedRowInComponent(0) == row {
            if row == 0 {
                reportLabel.text = String(picker2Options[row]) + " - " + hD.month + " " + hD.year
            }
            else if row == 1 {
                reportLabel.text = String(picker2Options[row]) + " - Quarter " + hD.quarter + " for " + hD.year
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}