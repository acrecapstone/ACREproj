//
//  HomePageViewController.swift
//  ACRE_App
//
//  Created by Tulsi Patel on 10/8/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import UIKit
import Foundation

@available(iOS 8.0, *)
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
    let dL = FEDataLayer()
    
    //intializing the arrays for the picker
    var picker1Options = [AreaDisplayer]()
    var picker2Options = []
    var timePickerRow = 0
    let dataProvider = DataProvider()
    
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
            picker1Options = dL.getAreas(acreDB)
            acreDB.close()
            picker2Options = ["Monthly", "Quarterly"]
        }
        else {
            print("Error: \(acreDB.lastErrorMessage())")
        }
        
        //*************************************************************************************************
        
        //if default timestamp isLater most recent timestamp {
        //hD = Pull Default area from SQLite
        //}
        //else {
        //hD = Pull recent area from SQLite
        //}
        
        //if hD.isMonth {
        //reportLabel.text = hD.month + " " + hD.year
        //set time picker to 0
        //}
        //else {
        //reportLabel.text = "Quarter " + hD.quarter + " for " + hD.year
        //set time picker to 1
        //}
        
        //var displayMth = hD.isMonth
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
            return "\(picker1Options[row].title)"
        }
        else
        {
            return "\(picker2Options[row])"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.isEqual(timeReportPickerView) {
            if timeReportPickerView.selectedRowInComponent(0) == row {
                medianPrice.textColor = UIColor.blackColor()
                listToSalesRatio.textColor = UIColor.blackColor()
                unitSales.textColor = UIColor.blackColor()
                volumeSales.textColor = UIColor.blackColor()
                dom.textColor = UIColor.blackColor()
                inventory.textColor = UIColor.blackColor()
                monthOfSupply.textColor = UIColor.blackColor()
                
                if row == 0 {
                    reportLabel.text = hD.month + " " + hD.year
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
                else if row == 1 {
                    reportLabel.text = "Quarter " + hD.quarter + " for " + hD.year
                    
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
        }
        else if pickerView.isEqual(mlsCityPickerView) {
            print("City changed")
            let areaID = picker1Options[mlsCityPickerView!.selectedRowInComponent(0)].areaID
            print(String(areaID))
            hD = dataProvider.requestHomeData(areaID)
            
            
            //hD = dataProvider.requestHomeData(3)
            
            //Store HD as most recent if areaID != default AreaID and store whether is monthly or quarterly, and timestamp
            //else update default Area's timestamp
            medianPrice.textColor = UIColor.blackColor()
            listToSalesRatio.textColor = UIColor.blackColor()
            unitSales.textColor = UIColor.blackColor()
            volumeSales.textColor = UIColor.blackColor()
            dom.textColor = UIColor.blackColor()
            inventory.textColor = UIColor.blackColor()
            monthOfSupply.textColor = UIColor.blackColor()
                
            if timePickerRow == 0 {
                reportLabel.text = hD.month + " " + hD.year
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
                else if timePickerRow == 1 {
                    reportLabel.text = "Quarter " + hD.quarter + " for " + hD.year
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
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}