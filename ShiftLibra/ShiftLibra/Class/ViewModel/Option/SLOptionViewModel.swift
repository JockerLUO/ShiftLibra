//
//  SLOptionViewModel.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

private let listPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString).appendingPathComponent("currency.plist")


class SLOptionViewModel: NSObject {
    
    static let shared = SLOptionViewModel()
    
    var currencyList : [String : [SLCurrency]]?
    
    var currencyTyeList : [String]?

    override init() {
        super.init()
        
        if let list : [String: [SLCurrency]] = SLSQLManager.shared.orderSQL() {
            
            if list.count > 0 {
                
                currencyList = list
                
                currencyTyeList = Array(currencyList!.keys).sorted()
                                
                return
            }
        }
        
        SLNetworkingTool.shared.getList(success: { (request) in
            
            guard let data = request as? [String : Any] else {
                
                return
            }
            
            guard let list = (data["result"] as? [String:Any])?["list"] as? [[String : Any]] else {
                
                return
            }
            
            guard let dataList = NSArray.yy_modelArray(with: SLCurrency.self, json: list) as? [SLCurrency] else {
                
                return
            }
            
            SLSQLManager.shared.insertToSQL(dataList: dataList)
            
            self.currencyList = SLSQLManager.shared.orderSQL()
            
            self.currencyTyeList = Array(self.currencyList!.keys).sorted()

        }, failure: { (error) in
            
            print("出错了",error)
        })
        
    }
    
}

extension SLOptionViewModel {
    
}
