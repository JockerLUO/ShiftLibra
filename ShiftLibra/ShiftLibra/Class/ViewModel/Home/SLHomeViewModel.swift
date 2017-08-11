//
//  SLHomeViewModel.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeViewModel: NSObject {
    
    static let shared : SLHomeViewModel = SLHomeViewModel()
    
    var toMoney : Double = 1.0
    
    var fromMoney : Double = 1.0
    
    var toMoneyDigits : String?
    
    var fromMoneyDigits : String?
    
    var fromCurrency : SLCurrency? {
        
        didSet {
            
            exchange = (fromCurrency?.exchange)! / (toCurrency?.exchange)!
        }
    }
    
    var toCurrency : SLCurrency? {
        
        didSet {
            
            exchange = (fromCurrency?.exchange)! / (toCurrency?.exchange)!
        }
    }
    
    var multiple : Double = 1.0 {
        
        didSet {
            
            changeMonyeAndDigits()
        }
    }
    
    var exchange : Double = 1.0
    
    override init() {
        
        super.init()
        
        fromCurrency = SLOptionViewModel.shared.queryList?[0]
        
        toCurrency = SLOptionViewModel.shared.queryList?[1]
        
        exchange = (fromCurrency?.exchange)! / (toCurrency?.exchange)!
        
        changeMonyeAndDigits()
    }
    
    func changeMonyeAndDigits() -> () {
        
        fromMoneyDigits = ""
        
        toMoneyDigits = ""
        
        if multiple > 1e11 {
            
            multiple = 1e10
        }
        
        if multiple < 1 {
            
            multiple = 1
        }
        
        fromMoney = multiple
        
        if fromMoney > 1e10 {
            
            fromMoney = fromMoney / 1e9
            
            fromMoneyDigits = "B"
            
        } else if fromMoney > 1e7 {
            
            fromMoney = fromMoney / 1e6
            
            fromMoneyDigits = "M"
            
        } else if fromMoney > 1e4 {
            
            fromMoney = fromMoney / 1e3
            
            fromMoneyDigits = "K"
        }
        
        toMoney = multiple * exchange
        
        
        if toMoney > 1e10 {
            
            toMoney = toMoney / 1e9
            
            toMoneyDigits = "B"
            
        } else if toMoney > 1e7 {
            
            toMoney = toMoney / 1e6
            
            toMoneyDigits = "M"
            
        } else if toMoney > 1e4 {
            
            toMoney = toMoney / 1e3
            
            toMoneyDigits = "K"
        }
        
        if toMoney < 10 {
            
            toMoney = (String(format: "%.2f", toMoney) as NSString).doubleValue
            
        } else {
            
            toMoney = Double(Int(toMoney))
        }
    }
}
