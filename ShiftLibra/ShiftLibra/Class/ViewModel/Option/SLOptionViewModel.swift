//
//  SLOptionViewModel.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import YYModel

private let listPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString).appendingPathComponent("currency.plist")

class SLOptionViewModel: NSObject {
    
    var customizeList : [SLCurrency]?
    
    var queryList : [SLCurrency]?
    
    var currencyTyeList : [String]?
    
    var currencyList : [String : [SLCurrency]]?
    
    override init() {
        
        super.init()
        
        if let list : [String: [SLCurrency]] = SLSQLManager.shared.orderSQL() {
            
            if list.count > 0 {
                
                customizeList = SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='customize';")
                
                queryList = SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
                
                let currency = queryList?[0]
                
                let dataFormatterStr : String = "YYYY-MM-dd HH:mm:ss"
                
                let dateF = DateFormatter()
                
                dateF.dateFormat = dataFormatterStr
                
                let createdTime = dateF.date(from: (currency?.updatetime!)!)
                
                let s = Int(-(createdTime?.timeIntervalSinceNow)!)
                
                if currency?.query == "minority" && s > 60 * 60 * 24 {
                    
                    getQuery()
                }
                
                currencyList = list
                
                currencyTyeList = Array(currencyList!.keys).sorted()
                
                if (customizeList?.count)! > 0 {
                    
                    currencyTyeList?.insert("query", at: 0)
                    
                    currencyTyeList?.insert("customize", at: 0)
                    
                    currencyList?.updateValue(queryList!, forKey: "query")
                    
                    currencyList?.updateValue(customizeList!, forKey: "customize")
                    
                } else {
                 
                    currencyTyeList?.insert("query", at: 0)

                    currencyList?.updateValue(queryList!, forKey: "query")
                }
                
                return
            }
        }
        
        let list : [String: [SLCurrency]] = SLSQLManager.sharedTmp.orderSQL()!
        
        queryList = SLSQLManager.sharedTmp.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
        
        currencyList = list
        
        currencyTyeList = Array(currencyList!.keys).sorted()
        
        currencyTyeList?.insert("query", at: 0)
        
        currencyList?.updateValue(queryList!, forKey: "query")
        
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
            
            ///从临时数据库中导入数据到创建的数据库
            for key in self.currencyTyeList! {
                
                let arr = self.currencyList?[key]
                
                for currency in  arr! {
                    
                    if currency.query != "query" {
                        
                        let sql : String = "UPDATE T_Currency set exchange=\(currency.exchange),query='\(currency.query ?? "")',updatetime='\(currency.updatetime ?? "")',name_English = '\(currency.name_English ?? "")' WHERE code='\(currency.code ?? "")';"
                        
                        SLSQLManager.shared.updateSQL(sql: sql)
                    }
                    
                    if currency.query == "query" {
                        
                        let sql : String = "UPDATE T_Currency set query='\(currency.query ?? "")',updatetime='\(currency.updatetime ?? "")',name_English = '\(currency.name_English ?? "")' WHERE code='\(currency.code ?? "")';"
                        
                        SLSQLManager.shared.updateSQL(sql: sql)
                    }
                    
                }
            }
            
            self.currencyList = SLSQLManager.shared.orderSQL()
            
            self.currencyTyeList = Array(self.currencyList!.keys).sorted()
            
            self.currencyTyeList?.insert("query", at: 0)
            
            self.currencyList?.updateValue(queryList, forKey: "query")

            
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
