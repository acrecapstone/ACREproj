//
//  FEDataLayer.swift
//  ACRE_App
//
//  Created by ACRE on 11/11/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit

class FEDataLayer {

    //Done - Walker
    func createACREDB() -> FMDatabase {
        
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        return FMDatabase(path: databasePath as String)
    }
    
    //Done - Lauren
    func invalidateAgent(dB : FMDatabase, mlsFeedID : Int) {
        let agentID2BInvalid = getAgentID4Feed(dB, mlsFeedID: mlsFeedID)
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "UPDATE AGENT isAuth = 0 WHERE agentID = \(agentID2BInvalid)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Done - Lauren
    func revalidateAgent(dB : FMDatabase, mlsFeedID : Int) {
        let agentID2BValid = getAgentID4Feed(dB, mlsFeedID: mlsFeedID)
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "UPDATE AGENT SET isAuth = 1 WHERE agentID = \(agentID2BValid)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Done - Lauren
    func updateLastLogin(dB: FMDatabase, mlsFeedID : Int) {
        let curTime = NSDate()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "UPDATE AGENT SET lastLogin = '\(curTime)' WHERE mlsFeedID = \(mlsFeedID)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
           dB.close()
        }
    }
    
    //Done - Walker
    func getInvalidAgentIDs(dB : FMDatabase) -> [Int] {
        var invalidAgents = [Int]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT lastLogin FROM AGENT WHERE isAuth = 0"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let agentCount = "SELECT COUNT(agentID) FROM AGENT WHERE isAuth = 0"
            
            var count = 0
            let cap = Int(dB.intForQuery(agentCount))
            invalidAgents = [Int](count: cap, repeatedValue: 0)
            
            while results?.next() == true {
                let id = results?.intForColumn("agentID")
                invalidAgents[count] = Int(id!)
                count++
            }
        }
        return invalidAgents
    }
    
    //Done - Walker
    func getValidAgentIDs(dB : FMDatabase) -> [Int] {
        var validAgents = [Int]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT agentID FROM AGENT WHERE isAuth = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let agentCount = "SELECT COUNT(agentID) FROM AGENT WHERE isAuth = 1"
            
            var count = 0
            let cap = Int(dB.intForQuery(agentCount))
            validAgents = [Int](count: cap, repeatedValue: 0)
            
            while results?.next() == true {
                let id = results?.intForColumn("agentID")
                validAgents[count] = Int(id!)
                count++
            }
        }
        return validAgents
    }
    
    //Done - Walker
    func getValidLastLogin(dB : FMDatabase, mlsFeedID : Int) -> NSDate {
        var lastLogin = NSDate()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT lastLogin FROM AGENT WHERE mlsFeedID = \(mlsFeedID) AND isAuth = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)

            while results?.next() == true {
                lastLogin = (results?.dateForColumn("lastLogin"))!
            }
            dB.close()
        }
        return lastLogin
    }
    
    //Done by Walker
    func getAgentID4Feed(dB : FMDatabase, mlsFeedID : Int) -> Int {
        var agentID = 0
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT agentID FROM AGENT WHERE mlsFeedID = \(mlsFeedID)"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                agentID = Int((results?.intForColumn("agentID"))!)
            }
            dB.close()
        }
        
        return agentID
    }
    
    //Needs Revision - Lauren
    func addAgent(dB : FMDatabase, token : String, mlsFeedID : Int, email : String, isAuth : Bool, lastLogin : NSDate) {
        let dB = createACREDB()
        if dB.open() {
            let insertSQL = "INSERT INTO AGENT (authToken, agentEmail, lastLogin, mlsFeedID, isAuth) VALUES ('\(token)', '\(email)', '\(lastLogin)', \(mlsFeedID), \(isAuth));"
            let result = dB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(dB.lastErrorMessage())")
            } else {
                print("Agent Added")
            }
            dB.close()
        }
    }
    
    //Done - Walker
    func getValidAgentFeedIDs(dB: FMDatabase) -> [Int] {
        var feedArr = [Int]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT mlsFeedID FROM AGENT WHERE isAuth = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let agentCount = "SELECT COUNT(mlsFeedID) FROM AGENT WHERE isAuth = 1"
            
            var count = 0
            let cap = Int(dB.intForQuery(agentCount))
            feedArr = [Int](count: cap, repeatedValue: 0)
            
            while results?.next() == true {
                let id = results?.intForColumn("mlsFeedID")
                feedArr[count] = Int(id!)
                count++
            }
        }
        return feedArr
    }
    //Done - Lauren
    func addStat(dB : FMDatabase, stat: Stat) {
        let dB = createACREDB()
        if dB.open() {
            let insert = "INSERT INTO STAT (statsID, areaID, isMonthly, timestamp, month, day, year, medPrice, medPricePrev, medPriceMth, medPriceQtr, medPricePerc, listSell, listSellPrev, listSellMth, listSellQtr, listSellPerc, unitSales, unitSalesPrev, unitSalesMth, unitSalesQtr, unitSalesPerc, volSales, volSalesPrev, volSalesMth, volSalesQtr, volSalesPerc, dom, domPrev, domMth, domQtr, domPerc, inv, invPRev, invMth, invQtr, invPerc, mos, mosPrev, mosMth, mosQtr, mosPerc) VALUES (\(stat.statsID), \(stat.areaID), \(stat.isMonthly), '\(stat.timestamp)', '\(stat.month)', \(stat.day), '\(stat.year), \(stat.medPrice), \(stat.medPricePrev), \(stat.medPriceMth), \(stat.medPriceQtr), \(stat.medPricePerc), \(stat.listSell), \(stat.listSellPrev), \(stat.listSellMth), \(stat.listSellQtr), \(stat.listSellPerc), \(stat.unitSales), \(stat.unitSalesPrev), \(stat.unitSalesMth), \(stat.unitSalesQtr), \(stat.unitSalesPerc), \(stat.volSales), \(stat.volSalesPrev), \(stat.volSalesMth), \(stat.volSalesQtr), \(stat.volSalesPerc), \(stat.dom), \(stat.domPrev), \(stat.domMth), \(stat.domQtr), \(stat.domPerc), \(stat.inv), \(stat.invPrev), \(stat.invMth), \(stat.invQtr), \(stat.invPerc), \(stat.mos), \(stat.mosPrev), \(stat.mosMth), \(stat.mosQtr), \(stat.mosPerc));"
            let result = dB.executeUpdate(insert, withArgumentsInArray: nil)
            if !result {
                print("Error: \(dB.lastErrorMessage())")
            }
            else {
                print("Stat Added")
            }
            dB.close()
        }
    }
    
    //Done - Lauren
    func getStats(dB : FMDatabase, areaID : Int) -> Stat {
        let stat = Stat()
        let dB = createACREDB()
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
    
    func deleteStat(dB: FMDatabase, areaID: Int) {
        let dB = createACREDB()
        if dB.open() {
            let sql = "DELETE FROM STATS WHERE areaID = \(areaID) AND isDefault = 0;"
            let results = dB.executeUpdate(sql, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Needs Revisions By Walker
    //Revised Update Statements - Lauren
    func updateRecAreaAndStat(dB : FMDatabase, nRecAreaID : Int) {
        let dB = createACREDB()
        if dB.open() {
            
            //Remove Default Settings of old Default
            
            //SET isDefault = false
            let querySQL1 = "UPDATE AREA SET isDefault = 0 WHERE isDefault = 1; UPDATE STATS SET isDefault = 0 WHERE isDefault = 1;"
            let results1 = dB.executeUpdate(querySQL1, withArgumentsInArray: nil)
            if !results1 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            //CALL DELETE STATS Func(nRecAreaID)
            deleteStat(dB, areaID: nRecAreaID)
            
            //Grant New Default Settings
            
            //SET isDefault = true
            let querySQL2 = "UPDATE AREA SET isDefault = 1 WHERE areaID = \(nRecAreaID); UPDATE STATS SET isDefault = 1 WHERE areaID = \(nRecAreaID);"
            let results2 = dB.executeUpdate(querySQL2, withArgumentsInArray: nil)
            if !results2 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            //CALL ADD STAT Function(nRecAreaID, stats)
            
            
            dB.close()
        }
    }
    
    //Needs Revisions - Walker
    //Revised Update Statements - Lauren
    func updateDefAreaAndStat(dB : FMDatabase, nDefAreaID : Int) {
        let dB = createACREDB()
        if dB.open() {
            
            //Remove Default Settings of old Default
           
            //SET isDefault = false
            let querySQL1 = "UPDATE AREA SET isDefault = 0 WHERE isDefault = 1; UPDATE AREA SET isDefault = 0 WHERE isDefault = 1;"
            let results1 = dB.executeUpdate(querySQL1, withArgumentsInArray: nil)
            if !results1 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            //CALL DELETE STATS Func(nDefAreaID)
            deleteStat(dB, areaID: nDefAreaID)
            
            //Grant New Default Settings
            
            //SET isDefault = true
            let querySQL2 = "UPDATE AREA SET isDefault = 1 WHERE areaID = \(nDefAreaID); UPDATE STATS SET isDefault = 1 WHERE areaID = \(nDefAreaID);"
            let results2 = dB.executeUpdate(querySQL2, withArgumentsInArray: nil)
            if !results2 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            //CALL ADD STAT Function(nDefAreaID, stats)
            
            dB.close()
        }
    }
    //Done - Walker
    func getDefaultAreaID(dB : FMDatabase) -> Int {
        var defAreaID = 0
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT areaID FROM AREA WHERE isDefault = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                defAreaID = Int((results?.intForColumn("areaID"))!)
            }
            dB.close()
        }
        
        return defAreaID
    }
    
    //Done - Walker
    func getDefaultStatsID(dB : FMDatabase) -> Int {
        var defStatID = 0
        let dB = createACREDB()
        if dB.open() {
            let querySQL = "SELECT statsID FROM STATS WHERE isDefault = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                defStatID = Int((results?.intForColumn("statsID"))!)
            }
            dB.close()
        }
        
        return defStatID
    }
    
    //Done - Walker
    func getRecentAreaID (dB : FMDatabase) -> Int {
        var recAreaID = 0
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT areaID FROM AREA WHERE isDefault = 0"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                recAreaID = Int((results?.intForColumn("areaID"))!)
            }
            dB.close()
        }
        
        return recAreaID
    }
    
    //Done By Walker
    func getRecentStatsID(dB : FMDatabase) -> Int {
        var recStatsID = 0
        let dB = createACREDB()
        if dB.open() {
            let querySQL = "SELECT statsID FROM STATS WHERE isDefault = 0"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                recStatsID = Int((results?.intForColumn("statsID"))!)
            }
            dB.close()
        }
        
        return recStatsID
    }
    
    //Unimplemented - Walker
    func getVersion(dB : FMDatabase) -> Int {
        
        return 0
    }
    
    //Done - Walker
    func getAreas(dB : FMDatabase) -> [AreaDisplayer] {
        var temp = [AreaDisplayer]()
        let dB = createACREDB()
        if dB.open() {
    
            let querySQL = "SELECT areaName, areaCode, areaID FROM AREA ORDER BY areaCode ASC"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
    
            let areaCount = "SELECT COUNT(areaID) FROM AREA"
    
            var count = 0
            let cap = Int(dB.intForQuery(areaCount))
            temp = [AreaDisplayer](count: cap, repeatedValue: AreaDisplayer())
    
            while results?.next() == true {
                let tempArea = AreaDisplayer()
                let id = results?.intForColumn("areaID")
                let code = results?.stringForColumn("areaCode")
                let name = results?.stringForColumn("areaName")
                let title = (code?.stringByAppendingString(" - " + name!))
                tempArea.title = title!
                tempArea.areaID = Int(id!)
                
                temp[count] = tempArea
                count++

            }
            dB.close()
        }
        return temp
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
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
}