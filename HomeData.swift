//
//  HomeData.swift
//  ACRE_App
//
//  Created by MacMini1 on 11/2/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class HomeData
{
    var areaID = Int();
    var statsID = Int();
    var month = String();
    var year = String();
    var quarter = String();
    var day = Int();
    var isDefault = Bool();
    var isMonthly = Bool();
    var timestamp = NSDate();
    
    
    var unitSales = Int();
    var unitSalesPrev = Int();
    var volumeSales = Int();
    var volumeSalesPrev = Int();
    var dOM = Int();
    var dOMPrev = Int();
    var mthUnitSalesPerc = Double();
    var mthVolumeSalesPerc = Double();
    var mthDOMPerc = Double();
    var qtrUnitSalesPerc = Double();
    var qtrVolumeSalesPerc = Double();
    var qtrDOMPerc = Double();
    
    var medianP = Double();
    var medianPPrev = Double();
    var listSell = Double();
    var listSellPrev = Double();
    var mthListSellPerc = Double();
    var mthMedianPPerc = Double();
    var qtrListSellPerc = Double();
    var qtrMedianPPerc = Double();
    
    var inv = Int();
    var invPrev = Int();
    var mOS = Double();
    var mOSPrev = Double();
    var mthMOSPerc = Double();
    var mthInvPerc = Double();
    var qtrInvPerc = Double();
    var qtrMOSPerc = Double();
    
    init()
    {
        
        self.areaID = 0;
        self.statsID = 0;
        self.month = "";
        self.year = "";
        self.quarter = "";
        self.day = 0;
        self.isDefault = false
        self.isMonthly = true
        self.timestamp = NSDate()
        
        self.unitSales = 0;
        self.unitSalesPrev = 0;
        self.volumeSales = 0;
        self.volumeSalesPrev = 0;
        self.dOM = 0;
        self.dOMPrev = 0;
        self.mthUnitSalesPerc = 0;
        self.mthVolumeSalesPerc = 0;
        self.mthDOMPerc = 0;
        self.qtrUnitSalesPerc = 0;
        self.qtrVolumeSalesPerc = 0;
        self.qtrDOMPerc = 0;
        
        self.medianP = 0;
        self.medianPPrev = 0;
        self.listSell = 0;
        self.listSellPrev = 0;
        self.mthMedianPPerc = 0;
        self.mthListSellPerc = 0;
        self.qtrMedianPPerc = 0;
        self.qtrListSellPerc = 0;
        
        self.inv = 0;
        self.invPrev = 0;
        self.mOS = 0;
        self.mOSPrev = 0;
        self.mthMOSPerc = 0;
        self.mthInvPerc = 0;
        self.qtrInvPerc = 0;
        self.qtrMOSPerc = 0;
    }
    
    func parseQuarter(month:String) -> String {
        
        //let d = today
        //let fullNameArr = fullName.characters.split("-")
        
        //let dateArr = d.characters.split{$0 == "-"}.map(String.init)
        //var lbD : LabelDate = LabelDate()
        //lbD.year = dateArr[0].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        //let tmpM = dateArr[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        switch month {
        case "Jan","Feb","Mar":
            return "4"
        case "Apr", "May", "June":
            return "1"
        case "July", "Aug", "Sept":
            return "2"
        case "Oct", "Nov", "Dec":
            return "3"
            
        default:
            return ""
        }
    }
}