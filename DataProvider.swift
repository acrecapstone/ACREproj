//
//  DataProvider.swift
//  ACRE_App
//
//  Created by MacMini1 on 10/20/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class DataProvider
{
    func requestAuthentication(email: String, mlsFeedID: Int) -> (Bool)
    {
        var endpoint = NSURL(string: "http://10.8.1.27/api/user/" + String(mlsFeedID) + "?email=" + email)
        var data = NSData(contentsOfURL: endpoint!)
        do
        {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                if let val = json["value"] as? Bool
                {
                    print(val)
                    return val
                }
            }
            return false
        }
            
        catch
        {
            return false
        }
    }
    
    func getAccess(email: String, mlsFeedID: Int, password: String) -> (Bool)
    {
        print(email)
        print(mlsFeedID)
        print(password)
        let endpoint1 = NSURL(string: "http://10.8.1.27/api/User?feedId=" + String(mlsFeedID) + "&email=" + email + "&authCode=" + password)
        let data = NSData(contentsOfURL: endpoint1!)
        do
        {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            {
                if let val1 = json["value"] as? Bool
                {
                    if val1
                    {
                        return true
                    }
                }
            }
            return false
        }
        catch
        {
            return false
        }
    }
    
    func requestHomeData(areaID: Int) -> (HomeData)
    {
        let hD: HomeData = HomeData.init()
        
        let endpoint = NSURL(string: "http://10.8.1.27/api/area/" + String(areaID))
        let data = NSData(contentsOfURL: endpoint!)
        
        do {
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                hD.month = (json["Month"] as? String)!
                hD.year = (json["Year"] as? String)!
                hD.day = (json["Day"] as? Int)!
                hD.quarter = hD.parseQuarter(hD.month)
                hD.AreaID = (json["AreaID"] as? Int)!
                hD.unitSales = (json["UnitSales"] as? Int)!
                hD.unitSalesPrev = (json["UnitSalesPrev"] as? Int)!
                hD.volumeSales = (json["VolumeSales"] as? Int)!
                hD.volumeSalesPrev = (json["VolumeSalesPrev"] as? Int)!
                hD.dOM = (json["DOM"] as? Int)!
                hD.dOMPrev = (json["DOMPrev"] as? Int)!
                hD.mthUnitSalesPerc = (json["MonthUnitSalesPercent"] as? Double)!
                hD.mthVolumeSalesPerc = (json["MonthVolumeSalesPercent1"] as? Double)! //is this suppose to be 1?
                hD.mthDOMPerc = (json["MonthDOMPercent"] as? Double)!
                hD.qtrUnitSalesPerc = (json["QuarterUnitSalesPercent"] as? Double)!
                hD.qtrVolumeSalesPerc = (json["QuarterVolumeSalesPercent"] as? Double)!
                hD.qtrDOMPerc = (json["QuarterDOMPercent"] as? Double)!
                
                hD.medianP = (json["MedianPrice"] as? Double)!
                hD.medianPPrev = (json["MedianPricePrevious"] as? Double)!
                hD.listSell = (json["ListSalePrice"] as? Double)!
                hD.listSellPrev = (json["ListSalePricePrevious"] as? Double)!
                hD.mthMedianPPerc = (json["MonthMedianPercent"] as? Double)!
                hD.mthListSellPerc = (json["MonthListSalePercent"] as? Double)!
                hD.qtrMedianPPerc = (json["QuarterMedianPercent"] as? Double)!
                hD.qtrListSellPerc = (json["QuarterListSalePercent"] as? Double)!
                
                hD.inv = (json["Inventory"] as? Int)!
                hD.invPrev = (json["InventoryPrevious"] as? Int)!
                hD.mOS = (json["MonthOfSupply"] as? Double)!
                hD.mOSPrev = (json["MonthOfSupplyPrevious"] as? Double)!
                hD.mthMOSPerc = (json["MonthMonthOfSupplyPercent"] as? Double)!
                hD.mthInvPerc = (json["MonthInventoryPercent"] as? Double)!
                hD.qtrInvPerc = (json["QuarterInventoryPercent"] as? Double)!
                hD.qtrMOSPerc = (json["QuarterMonthOfSupplyPercent"] as? Double)!
                
                return hD
            }
            return hD
        }
        catch {
            
            print("Error")
            return hD
        }
    }
}
