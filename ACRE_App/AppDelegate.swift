//
//  AppDelegate.swift
//  ACRE_App
//
//  Created by MacMini1 on 10/8/15.
//  Copyright © 2015 AcreApp.Practice. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let filemgr = NSFileManager.defaultManager()
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("database.sqlite")
        let databasePath = fileURL.path!
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            let acreDB = FMDatabase(path: databasePath as String)
            if acreDB == nil {
                print("Error: \(acreDB.lastErrorMessage())")
            }
            if acreDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS AGENT (agentID INTEGER PRIMARY KEY AUTOINCREMENT, authToken TEXT, agentEmail TEXT, lastLogin DATETIME, mlsFeedID INTEGER); CREATE TABLE IF NOT EXISTS LEAD (leadID INTEGER PRIMARY KEY AUTOINCREMENT, agentID INTEGER, leadName TEXT, leadEmail TEXT, leadPhone TEXT, leadArea TEXT, leadNotes TEXT, isType BOOL, FOREIGN KEY (agentID) REFERENCES AGENT(agentID)); CREATE TABLE IF NOT EXISTS MLSFEED (mlsFeedID INTEGER PRIMARY KEY AUTOINCREMENT, feedName TEXT, agentEmail TEXT, lastLogin DATETIME); CREATE TABLE IF NOT EXISTS AREA (areaID INTEGER PRIMARY KEY AUTOINCREMENT, areaCode INTEGER, areaName TEXT, isFavorite BOOL); CREATE TABLE IF NOT EXISTS VERSION (versionID INTEGER PRIMARY KEY AUTOINCREMENT, dateUpdated DATETIME, notes TEXT)"
                
                if !acreDB.executeStatements(sql_stmt) {
                    print("Error: \(acreDB.lastErrorMessage())")
                }
                
                acreDB.close()
            }
            else {
                print("Error: \(acreDB.lastErrorMessage())")
            }
        }
        else{
            print("Success")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

