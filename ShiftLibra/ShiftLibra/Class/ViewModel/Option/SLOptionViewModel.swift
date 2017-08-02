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
    
    var currencyList : [SLCurrency]? {
        
        didSet {
            
            
            
            
        }
        
    }
    
    override init() {
        super.init()
        
        if let list : [SLCurrency] = self.getcurrencyList() {
            
            if list.count > 0 {
            
            self.currencyList = list
            
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
            
            let tmpList = [String : [SLCurrency]]()
            
            for currency in dataList {
                
                let code = currency.code
                
                let index = code?.index((code?.startIndex)!, offsetBy: 1)
                
//                let str = code?.substring(to: index))
                let key = code?.substring(to: index!)
            }
             
            
            
            self.saveCurrencyList(list: dataList)
            
        }, failure: { (error) in
            
            print("出错了",error)
        })
        
    }

}

extension SLOptionViewModel {
    
    fileprivate func saveCurrencyList(list : [SLCurrency]) -> () {
        
        self.currencyList = list
        
        NSKeyedArchiver.archiveRootObject(list, toFile: listPath)
    }
    
    func getcurrencyList() -> [SLCurrency]? {
        let user = NSKeyedUnarchiver.unarchiveObject(withFile: listPath) as? [SLCurrency]
        return user
    }
    
}
