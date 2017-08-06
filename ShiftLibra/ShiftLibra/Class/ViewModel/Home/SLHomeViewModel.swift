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
    
    var fromCurrency : SLCurrency? {
        
        didSet {
            
            exchange = (toCurrency?.exchange)! / (fromCurrency?.exchange)!
        }
        
    }
    
    var toCurrency : SLCurrency? {
        
        didSet {
            
            exchange = (toCurrency?.exchange)! / (fromCurrency?.exchange)!
        }
    }
    
    var multiple : Double = 1.0
    
    var exchange : Double = 1.0
    
    override init() {
        
        super.init()
        
        fromCurrency = SLOptionViewModel.shared.queryList?[0]
        
        toCurrency = SLOptionViewModel.shared.queryList?[1]
        
        exchange = (toCurrency?.exchange)! / (fromCurrency?.exchange)!
        
    }
}
