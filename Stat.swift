//
//  Stat.swift
//  ACRE_App
//
//  Created by MacMini1 on 11/12/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class Stat {
    
    var statsID = Int()
    var areaID = Int()
    var isDefault = Bool()
    var isMonthly = Bool()
    var timestamp = NSDate()
    var month = String()
    var day = Int()
    var year = String()
    
    var medPrice = Double()
    var medPricePrev = Double()
    var medPriceMth = Double()
    var medPriceQtr = Double()
    var medPricePerc = Double()
    
    var listSell = Double()
    var listSellPrev = Double()
    var listSellMth = Double()
    var listSellQtr = Double()
    var listSellPerc = Double()
    
    var unitSales = Int()
    var unitSalesPrev = Int()
    var unitSalesMth = Int()
    var unitSalesQtr = Int()
    var unitSalesPerc = Double()
    
    var volSales = Int()
    var volSalesPrev = Int()
    var volSalesMth = Int()
    var volSalesQtr = Int()
    var volSalesPerc = Double()
    
    var dom = Int()
    var domPrev = Int()
    var domMth = Int()
    var domQtr = Int()
    var domPerc = Double()
    
    var inv = Int()
    var invPrev = Int()
    var invMth = Int()
    var invQtr = Int()
    var invPerc = Double()
    
    var mos = Double()
    var mosPrev = Double()
    var mosMth = Double()
    var mosQtr = Double()
    var mosPerc = Double()

    init() {
        
    }
    
    
    
    func getStats(dB : FMDatabase, areaID : Int) -> Stat {
        var stat = Stat()
        if dB.open() {
            let query = "SELECT * FROM STAT WHERE areaID = \(areaID)"
            let result = dB.executeQuery(query, withArgumentsInArray: nil)
            while result.next() {
                stat.statsID = Int((result?.intForColumn("statsID"))!)
                stat.areaID = Int((result?.intForColumn("areaID"))!)
                stat.isDefault = (result?.boolForColumn("isDefault"))!
                stat.isMonthly = (result?.boolForColumn("isMonthly"))!
                stat.timestamp = (result?.dateForColumn("timestamp"))!
                stat.month = (result?.stringForColumn("month"))!
                stat.day = Int((result?.intForColumn("day"))!)
                stat.year = (result?.stringForColumn("year"))!
                stat.medPrice = (result?.doubleForColumn("medPrice"))!
                stat.medPricePrev = (result?.doubleForColumn("medPricePrev"))!
                stat.medPriceMth = (result?.doubleForColumn("medPriceMth"))!
                stat.medPriceQtr = (result?.doubleForColumn("medPriceQtr"))!
                stat.medPricePerc = (result?.doubleForColumn("medPricePerc"))!
                stat.listSell = (result?.doubleForColumn("listSell"))!
                stat.listSellPrev = (result?.doubleForColumn("listSellPrev"))!
                stat.listSellMth = (result?.doubleForColumn("listSellMth"))!
                stat.listSellQtr = (result?.doubleForColumn("listSellQtr"))!
                stat.listSellPerc = (result?.doubleForColumn("listSellPerc"))!
                stat.unitSales = Int((result?.intForColumn("unitSales"))!)
                stat.unitSalesPrev = Int((result?.intForColumn("unitSalesPrev"))!)
                stat.unitSalesMth = Int((result?.intForColumn("unitSalesMth"))!)
                stat.unitSalesQtr = Int((result?.intForColumn("unitSalesQtr"))!)
                stat.unitSalesPerc = (result?.doubleForColumn("unitSalesPerc"))!
                stat.volSales = Int((result?.intForColumn("unitSales"))!)
                stat.volSalesPrev = Int((result?.intForColumn("unitSalesPrev"))!)
                stat.volSalesMth = Int((result?.intForColumn("unitSalesMth"))!)
                stat.volSalesQtr = Int((result?.intForColumn("unitSalesQtr"))!)
                stat.volSalesPerc = (result?.doubleForColumn("volSalesPerc"))!
                stat.dom = Int((result?.intForColumn("dom"))!)
                stat.domPrev = Int((result?.intForColumn("domPrev"))!)
                stat.domMth = Int((result?.intForColumn("domMth"))!)
                stat.domQtr = Int((result?.intForColumn("domQtr"))!)
                stat.domPerc = (result?.doubleForColumn("domPerc"))!
                stat.inv = Int((result?.intForColumn("dom"))!)
                stat.invPrev = Int((result?.intForColumn("domPrev"))!)
                stat.invMth = Int((result?.intForColumn("domMth"))!)
                stat.invQtr = Int((result?.intForColumn("domQtr"))!)
                stat.invPerc = (result?.doubleForColumn("invPerc"))!
                stat.mos = (result?.doubleForColumn("mos"))!
                stat.mosPrev = (result?.doubleForColumn("mosPrev"))!
                stat.mosMth = (result?.doubleForColumn("mosMth"))!
                stat.mosQtr = (result?.doubleForColumn("mosQtr"))!
                stat.mosPerc = (result?.doubleForColumn("mosPerc"))!
            }
        }
        dB.close()
        
        return stat
    }
    
    
    func addStat(dB : FMDatabase) {
        if dB.open() {
            
        }
        dB.close()
    }
    
    func updateStat(dB : FMDatabase) {
        if dB.open() {
            
        }
        dB.close()
    }
    
    
    
    func invalidateAgent(dB : FMDatabase, mlsFeedID : Int) {
        let agentID2BInvalid = getAgentID4Feed(dB, mlsFeedID: mlsFeedID)
        
        if dB.open() {
            
            let querySQL = "UPDATE AGENT isAuth = 0 WHERE agentID = \(agentID2BInvalid)"
            let results: FMResultSet? = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !(results != nil) {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    
    //Revised - Lauren
    func revalidateAgent(dB : FMDatabase, mlsFeedID : Int) {
        let agentID2BValid = getAgentID4Feed(dB, mlsFeedID: mlsFeedID)
        
        if dB.open() {
            
            let querySQL = "UPDATE AGENT SET isAuth = 1 WHERE agentID = \(agentID2BValid)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
        }
        dB.close()
    }
    //Revised - Lauren
    func updateLastLogin(dB: FMDatabase, mlsFeedID : Int) {
        var curTime = NSDate()
        
        if dB.open() {
            
            let querySQL = "UPDATE AGENT SET lastLogin = '\(curTime)' WHERE mlsFeedID = \(mlsFeedID)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            
        }
        dB.close()
    }
    

    
    func addAgent(dB : FMDatabase, token : String, email : String, lastLogin : NSDate, mlsFeedID : Int, isAuth : Bool) {
        if dB.open() {
            let agent = "SELECT "
            if {
                let insertSQL = "INSERT INTO AGENT (authToken, agentEmail, lastLogin, mlsFeedID, isAuth) VALUES ('\(token)', '\(email)', '\(lastLogin)', \(mlsFeedID), \(isAuth));"
                let result = dB.executeUpdate(insertSQL, withArgumentsInArray: nil)
                
                if !result {
                    print("Error: \(dB.lastErrorMessage())")
                } else {
                    print("Agent Added")
                }
            }
        }
    
    
    
    
    
    
 
    
}

