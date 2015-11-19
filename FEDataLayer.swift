//
//  FEDataLayer.swift
//  ACRE_App
//
//  Created by ACRE on 11/11/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import Foundation
import UIKit
@available(iOS 8.0, *)
class FEDataLayer {
    
    //Done - Walker
    func createACREDB() -> FMDatabase {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        return FMDatabase(path: databasePath as String)
    }
    
    //Done - Lauren
    func invalidateAgent(mlsFeedID : Int) {
        let agentID2BInvalid = getAgentID4Feed(mlsFeedID)
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "UPDATE AGENT SET isAuth = 0 WHERE agentID = \(agentID2BInvalid)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Done - Lauren
    func revalidateAgent(mlsFeedID : Int) {
        let agentID2BValid = getAgentID4Feed(mlsFeedID)
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
    func updateLastLogin(mlsFeedID : Int) {
        let curTime = NSDate()
        let dB = createACREDB()
        if dB.open() {
            print("New Login")
            print(String(curTime))
            let querySQL = "UPDATE AGENT SET lastLogin = '\(curTime)' WHERE mlsFeedID = \(mlsFeedID)"
            let results = dB.executeUpdate(querySQL, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Done Walker
    //LAUREN please look over this
    func getInvalidAgents() -> [Agent] {
        var temp = [Agent]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT agentID, authToken, agentEmail, mlsFeedID, lastLogin, isAuth FROM AGENT WHERE isAuth = 0"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let agentCount = "SELECT COUNT(agentID) FROM AGENT"
            
            var count = 0
            let cap = Int(dB.intForQuery(agentCount))
            temp = [Agent](count: cap, repeatedValue: Agent())
            
            while results?.next() == true {
                let tempAgent = Agent()
                
                let id = results?.intForColumn("agentID")
                let feedID = results?.intForColumn("mlsFeedID")
                let token = results?.stringForColumn("authToken")
                let login = results?.dateForColumn("lastLogin")
                let isAuth = results?.boolForColumn("isAuth")
                let email = results?.stringForColumn("agentEmail")
                
                tempAgent.agentID = Int(id!)
                tempAgent.mlsFeedID = Int(feedID!)
                tempAgent.authToken = token!
                tempAgent.lastLogin = login!
                tempAgent.isAuth = isAuth!
                tempAgent.agentEmail = email!
                
                
                temp[count] = tempAgent
                count++
                
            }
            dB.close()
        }
        return temp
    }
    
    
    //Done Walker
    //LAUREN please look over this
    func getValidAgents() -> [Agent] {
        var temp = [Agent]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT agentID, authToken, agentEmail, mlsFeedID, lastLogin, isAuth FROM AGENT WHERE isAuth = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let agentCount = "SELECT COUNT(agentID) FROM AGENT"
            
            var count = 0
            let cap = Int(dB.intForQuery(agentCount))
            temp = [Agent](count: cap, repeatedValue: Agent())
            
            while results?.next() == true {
                let tempAgent = Agent()
                
                let id = results?.intForColumn("agentID")
                let feedID = results?.intForColumn("mlsFeedID")
                let token = results?.stringForColumn("authToken")
                let login = results?.dateForColumn("lastLogin")
                let isAuth = results?.boolForColumn("isAuth")
                let email = results?.stringForColumn("agentEmail")
                
                tempAgent.agentID = Int(id!)
                tempAgent.mlsFeedID = Int(feedID!)
                tempAgent.authToken = token!
                tempAgent.lastLogin = login!
                tempAgent.isAuth = isAuth!
                tempAgent.agentEmail = email!
                
                
                temp[count] = tempAgent
                count++
                
            }
            dB.close()
        }
        return temp
    }
    
    //Done - Walker
    func getValidLastLogin(mlsFeedID : Int) -> NSDate {
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
    func getAgentID4Feed(mlsFeedID : Int) -> Int {
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
    func addAgent(token : String, mlsFeedID : Int, email : String, isAuth : Bool) {
        let dB = createACREDB()
        var boolVal = 0
        if isAuth {
            boolVal = 1
        }
        else {
            boolVal = 0
        }
        if dB.open() {
            let insertSQL = "INSERT INTO AGENT (authToken, agentEmail, lastLogin, mlsFeedID, isAuth) VALUES ('\(token)', '\(email)', '\(NSDate())', \(mlsFeedID), \(boolVal));"
            let result = dB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if !result {
                print("Error: \(dB.lastErrorMessage())")
            } else {
                print("Agent Added")
            }
            dB.close()
        }
    }
    //Done By Walker
    func deleteAgent(mlsFeedID: Int) {
        let dB = createACREDB()
        if dB.open() {
            let sql = "DELETE FROM AGENT WHERE mlsFeedID = \(mlsFeedID);"
            let results = dB.executeUpdate(sql, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Done - Walker
    func getValidAgentFeedIDs() -> [Int] {
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
    func addStat(stat: HomeData) {
        let dB = createACREDB()
        if dB.open() {
            let insert = "INSERT INTO STAT (statsID, areaID, isMonthly, timestamp, month, day, year, medPrice, medPricePrev, medPriceMth, medPriceQtr, listSell, listSellPrev, listSellMth, listSellQtr, unitSales, unitSalesPrev, unitSalesMth, unitSalesQtr, volSales, volSalesPrev, volSalesMth, volSalesQtr, dom, domPrev, domMth, domQtr, inv, invPRev, invMth, invQtr, mos, mosPrev, mosMth, mosQtr) VALUES (\(stat.statsID), \(stat.areaID), \(stat.isMonthly), '\(stat.timestamp)', '\(stat.month)', \(stat.day), '\(stat.year), \(stat.medianP), \(stat.medianPPrev), \(stat.mthMedianPPerc), \(stat.qtrMedianPPerc), \(stat.listSell), \(stat.listSellPrev), \(stat.mthListSellPerc), \(stat.qtrListSellPerc), \(stat.unitSales), \(stat.unitSalesPrev), \(stat.mthUnitSalesPerc), \(stat.qtrUnitSalesPerc), \(stat.volumeSales), \(stat.volumeSalesPrev), \(stat.mthVolumeSalesPerc), \(stat.qtrVolumeSalesPerc), \(stat.dOM), \(stat.dOMPrev), \(stat.mthDOMPerc), \(stat.qtrDOMPerc), \(stat.inv), \(stat.invPrev), \(stat.mthInvPerc), \(stat.qtrInvPerc), \(stat.mOS), \(stat.mOSPrev), \(stat.mthMOSPerc), \(stat.qtrMOSPerc));"
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
    func getStats(areaID : Int) -> HomeData {
        let stat = HomeData()
        let dB = createACREDB()
        if dB.open() {
            let query = "SELECT * FROM STATS WHERE areaID = \(areaID)"
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
                stat.medianP = (result?.doubleForColumn("medPrice"))!
                stat.medianPPrev = (result?.doubleForColumn("medPricePrev"))!
                stat.mthMedianPPerc = (result?.doubleForColumn("medPriceMth"))!
                stat.qtrMedianPPerc = (result?.doubleForColumn("medPriceQtr"))!
                
                stat.listSell = (result?.doubleForColumn("listSell"))!
                stat.listSellPrev = (result?.doubleForColumn("listSellPrev"))!
                stat.mthListSellPerc = (result?.doubleForColumn("listSellMth"))!
                stat.qtrListSellPerc = (result?.doubleForColumn("listSellQtr"))!
                
                stat.unitSales = Int((result?.intForColumn("unitSales"))!)
                stat.unitSalesPrev = Int((result?.intForColumn("unitSalesPrev"))!)
                stat.mthUnitSalesPerc = (result?.doubleForColumn("unitSalesMth"))!
                stat.qtrUnitSalesPerc = (result?.doubleForColumn("unitSalesQtr"))!
                
                stat.volumeSales = Int((result?.intForColumn("unitSales"))!)
                stat.volumeSalesPrev = Int((result?.intForColumn("unitSalesPrev"))!)
                stat.mthVolumeSalesPerc = (result?.doubleForColumn("unitSalesMth"))!
                stat.qtrVolumeSalesPerc = (result?.doubleForColumn("unitSalesQtr"))!
                
                stat.dOM = Int((result?.intForColumn("dom"))!)
                stat.dOMPrev = Int((result?.intForColumn("domPrev"))!)
                stat.mthDOMPerc = (result?.doubleForColumn("domMth"))!
                stat.qtrDOMPerc = (result?.doubleForColumn("domQtr"))!
                
                stat.inv = Int((result?.intForColumn("inv"))!)
                stat.invPrev = Int((result?.intForColumn("invPrev"))!)
                stat.mthInvPerc = (result?.doubleForColumn("invMth"))!
                stat.qtrInvPerc = (result?.doubleForColumn("invQtr"))!
                
                stat.mOS = (result?.doubleForColumn("mos"))!
                stat.mOSPrev = (result?.doubleForColumn("mosPrev"))!
                stat.mthMOSPerc = (result?.doubleForColumn("mosMth"))!
                stat.qtrMOSPerc = (result?.doubleForColumn("mosQtr"))!
                
            }
        }
        dB.close()
        
        return stat
    }
    
    func deleteStat(areaID: Int) {
        let dB = createACREDB()
        if dB.open() {
            let sql = "DELETE FROM STATS WHERE areaID = \(areaID);"
            let results = dB.executeUpdate(sql, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
            dB.close()
        }
    }
    
    //Needs Revisions By Walker
    //Revised Update Statements - Lauren
    func updateRecAreaAndStat(nRecAreaID : Int) {
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
            deleteStat(nRecAreaID)
            
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
    func updateDefAreaAndStat(nDefAreaID : Int, isMonthly : Bool) {
        //Remove Default Settings of old Defaul stat

        deleteStat(getDefaultAreaID())
        var newStat = HomeData()
        let dB = createACREDB()
        
        if dB.open() {
            let querySQL1 = "UPDATE AREA SET isDefault = 0 WHERE isDefault = 1;"
            let results1 = dB.executeUpdate(querySQL1, withArgumentsInArray: nil)
            if !results1 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            //Grant New Default Settings
            let querySQL2 = "UPDATE AREA SET isDefault = 1 WHERE areaID = \(nDefAreaID);"
            let results2 = dB.executeUpdate(querySQL2, withArgumentsInArray: nil)
            if !results2 {
                print("Error: \(dB.lastErrorMessage())")
            }
            
            dB.close()
        }
        
        let DP = DataProvider()
        
        newStat = DP.requestHomeData(nDefAreaID)
        
        newStat.isMonthly = isMonthly
        
        addStat(newStat)
    }
    
    func initialDefault(areaID: Int) {
        let dB = createACREDB()
        if dB.open() {
            let sql = "UPDATE AREA SET isDefault = 1 WHERE areaID = \(areaID)"
            let results = dB.executeUpdate(sql, withArgumentsInArray: nil)
            if !results {
                print("Error: \(dB.lastErrorMessage())")
            }
        }
    }
    
    //Done - Walker
    func getDefaultAreaID() -> Int {
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
    
    func getDefaultTimePref() -> Bool {
        var isMonthly = true
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT isMonthly FROM AREA WHERE isDefault = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                isMonthly = (results?.boolForColumn("isMonthly"))!
            }
            dB.close()
        }
        
        return isMonthly
    }
    
    //Done By Walker
    func getDefaultTimestamp() -> NSDate {
        var time = NSDate()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT timestamp FROM STATS WHERE isDefault = 1"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                time = (results?.dateForColumn("timestamp"))!
            }
            dB.close()
        }
        
        return time
    }
    
    //Done By Walker
    func getRecentTimestamp() -> NSDate {
        var time = NSDate()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT timestamp FROM STATS WHERE isDefault = 0"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                time = (results?.dateForColumn("timestamp"))!
            }
            dB.close()
        }
        
        return time
    }
    
    //Done - Walker
    func getDefaultStatsID() -> Int {
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
    func getRecentAreaID () -> Int {
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
    func getRecentStatsID() -> Int {
        var recStatsID = 0
        let dB = createACREDB()
        if dB.open() {
            let querySQL = "SELECT statsID FROM STATS WHERE isDefault = 0;"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                recStatsID = Int((results?.intForColumn("statsID"))!)
            }
            dB.close()
        }
        
        return recStatsID
    }
    
    //Unimplemented - Walker
    func getVersion() -> Int {
        
        return 0
    }
    //Done By Walker
    //Lauren Please Review
    func getMLSFeeds() -> [MLSFeed] {
        var temp = [MLSFeed]()
        let dB = createACREDB()
        if dB.open() {
            
            let querySQL = "SELECT feedName, mlsFeedID FROM MLSFEED ORDER BY feedName ASC"
            let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            let feedCount = "SELECT COUNT(mlsFeedID) FROM MLSFEED"
            
            var count = 0
            let cap = Int(dB.intForQuery(feedCount))
            temp = [MLSFeed](count: cap, repeatedValue: MLSFeed())
            
            while results?.next() == true {
                let tempFeed = MLSFeed()
                let id = results?.intForColumn("mlsFeedID")
                let name = results?.stringForColumn("feedName")
                
                tempFeed.mlsFeedID = Int(id!)
                tempFeed.mlsFeedName = name!
                
                temp[count] = tempFeed
                count++
            }
            dB.close()
        }
        return temp
    }
    
    //Done - Walker
    func getAreas() -> [AreaDisplayer] {
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
    
    //Not DONE
    //STILL WORKING ON THIS
    func InDevelopmentGetAreas() -> [AreaDisplayer] {
        var temp = [AreaDisplayer]()
        let FEDL = FEDataLayer()
        let agents = FEDL.getValidAgents()
        
        let dB = createACREDB()
        if dB.open() {
            for agent in agents {
                let querySQL = "SELECT areaName, areaCode, areaID FROM AREA ORDER BY areaCode ASC WHERE mlsFeedID = \(agent.mlsFeedID)"
                let results: FMResultSet? = dB.executeQuery(querySQL, withArgumentsInArray: nil)
                
                while results?.next() == true {
                    let tempArea = AreaDisplayer()
                    let id = results?.intForColumn("areaID")
                    let code = results?.stringForColumn("areaCode")
                    let name = results?.stringForColumn("areaName")
                    let title = (code?.stringByAppendingString(" - " + name!))
                    tempArea.title = title!
                    tempArea.areaID = Int(id!)
                    
                    temp.append(tempArea)
                }
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