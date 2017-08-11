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
        
    var queryList : [SLCurrency]?
    
    var currencyTyeList : [String]?
    
    var currencyList : [String : [SLCurrency]]?
    
    override init() {
        
        super.init()
        
        if let list : [String: [SLCurrency]] = SLSQLManager.shared.orderSQL() {
            
            if list.count > 0 {
                
                queryList = SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
                
                currencyList = list
                
                currencyTyeList = Array(currencyList!.keys).sorted()
                
                return
            }
        }
        
        let list : [String: [SLCurrency]] = SLTmpSQLManager.shared.orderSQL()!
        
        queryList = SLTmpSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
        
        currencyList = list
        
        currencyTyeList = Array(currencyList!.keys).sorted()
        
        getList()
    }
    
    private func getList() -> () {
        
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
            
            self.getQuery()
            
            
        }, failure: { (error) in
            
            print("出错了",error)
        })
    }
    
    
    
    private func getQuery() -> () {
        
        SLNetworkingTool.shared.getQuery(success: { (request) in
            
            guard let data = request as? [String : Any] else {
                
                return
            }
            
            guard let result = data["result"] as? [String:Any] else {
                
                return
            }

            guard let list = result["list"] as? [[String]] else {
                
                return
            }
            
            let updatetime : String = result["update"] as! String
            
            var queryList : [SLCurrency] = [SLCurrency]()
            
            ///人民币处理
            if let obj = self.select(key: "人民币").first {
                
                obj.query = "query"
                
                obj.exchange = 1.0
                
                obj.updatetime = updatetime
                
                let sql : String = "UPDATE T_Currency set exchange=\(obj.exchange),query='query',updatetime='\(updatetime)' WHERE name='人民币';"
                
                self.update(sql: sql)
                
                queryList.append(obj)
            }
            
            for currency in list {
                
                let name = currency[0]
                
                let count = Double(currency[1]) ?? 1.0
                
                let bankPice = Double(currency[5]) ?? 1.0
                
                let exchange = bankPice / count
                
                guard let obj = self.select(key: name).first else {
                    
                    continue
                }
                
                obj.query = "query"
                
                obj.exchange = exchange
                
                obj.updatetime = updatetime
                
                let sql : String = "UPDATE T_Currency set exchange=\(exchange),query='query',updatetime='\(updatetime)' WHERE name='\(name)';"
                
                self.update(sql: sql)
                
                queryList.append(obj)
            }
            
            self.currencyList = SLSQLManager.shared.orderSQL()
            
            self.currencyTyeList = Array(self.currencyList!.keys).sorted()
            
            self.queryList = queryList
            
        }, failure: { (error) in
            
            print("出错了",error)
        })
    }
}

extension SLOptionViewModel {
    
    func update(sql : String) -> () {
        
       SLSQLManager.shared.updateSQL(sql: sql)
    }
    
    func select(key : String) -> [SLCurrency] {
        
        let sql : String = "SELECT * FROM T_Currency WHERE name='\(key)' OR code = '\(key)';"
        
        return SLSQLManager.shared.selectSQL(sql: sql)
    }
    
    
    
    
}
