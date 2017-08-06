//
//  SLCurrency.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import YYModel

class SLCurrency: NSObject,NSCoding {
    
    var code : String?
    
    var name : String?
    
    var exchange : Double = 0.0
    
    var updatetime : String?
    
    var query : String?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.yy_modelInit(with: aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.yy_modelEncode(with: aCoder)
    }
}
