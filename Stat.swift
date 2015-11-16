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
        self.statsID = Int()
        self.areaID = Int()
        self.isDefault = Bool()
        self.isMonthly = Bool()
        self.timestamp = NSDate()
        self.month = String()
        self.day = Int()
        self.year = String()
        
        self.medPrice = Double()
        self.medPricePrev = Double()
        self.medPriceMth = Double()
        self.medPriceQtr = Double()
        self.medPricePerc = Double()
        
        self.listSell = Double()
        self.listSellPrev = Double()
        self.listSellMth = Double()
        self.listSellQtr = Double()
        self.listSellPerc = Double()
        
        self.unitSales = Int()
        self.unitSalesPrev = Int()
        self.unitSalesMth = Int()
        self.unitSalesQtr = Int()
        self.unitSalesPerc = Double()
        
        self.volSales = Int()
        self.volSalesPrev = Int()
        self.volSalesMth = Int()
        self.volSalesQtr = Int()
        self.volSalesPerc = Double()
        
        self.dom = Int()
        self.domPrev = Int()
        self.domMth = Int()
        self.domQtr = Int()
        self.domPerc = Double()
        
        self.inv = Int()
        self.invPrev = Int()
        self.invMth = Int()
        self.invQtr = Int()
        self.invPerc = Double()
        
        self.mos = Double()
        self.mosPrev = Double()
        self.mosMth = Double()
        self.mosQtr = Double()
        self.mosPerc = Double()
    }
    
    
}

