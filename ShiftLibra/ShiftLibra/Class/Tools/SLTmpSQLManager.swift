//
//  SLTmpSQLManager.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/11.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import FMDB

class SLTmpSQLManager{
    
    static let shared: SLTmpSQLManager = SLTmpSQLManager()
    
    let queue: FMDatabaseQueue
    
    let path = Bundle.main.path(forResource: "currency_tmp.db", ofType: nil) ?? ""
    
    init() {
        
        queue = FMDatabaseQueue(path: path)
        
    }
}

extension SLTmpSQLManager{
    
    func insertToSQL(dataList : [SLCurrency]) -> () {
        
        SLTmpSQLManager.shared.queue.inTransaction({ (db, rollback) in
            
            for obj in dataList {
                
                let sql = "INSERT INTO T_Currency (name,code) VALUES('\(obj.name!)','\(obj.code!)')"
                
                db.executeStatements(sql)
            }
            
        })
    }
    
    
    func orderSQL() -> [String : [SLCurrency]]? {
        
        var list : [String: [SLCurrency]] = [String : [SLCurrency]]()
        
        let sql = "SELECT * FROM T_Currency ORDER BY code;"
        
        SLTmpSQLManager.shared.queue.inDatabase { (db) -> Void in
            
            guard let rs = db.executeQuery(sql, withParameterDictionary: nil) else {
                return
            }
            
            while rs.next() {
                
                let obj : SLCurrency = SLCurrency()
                
                obj.name = rs.string(forColumn: "name")
                obj.code = rs.string(forColumn: "code")
                obj.updatetime = rs.string(forColumn: "updatetime")
                obj.exchange = rs.double(forColumn: "exchange")
                obj.query = rs.string(forColumn: "query")
                
                let mainString = obj.code ?? "CNY"
                
                let index = mainString.index(mainString.startIndex, offsetBy: 1)
                
                let key = mainString.substring(to: index)
                
                if list[key] == nil {
                    
                    list[key] = [SLCurrency]()
                }
                
                list[key]?.append(obj)
            }
        }
        
        return list
    }
    
    func selectSQL(sql : String) -> [SLCurrency] {
        
        var list : [SLCurrency] = [SLCurrency]()
        
        SLTmpSQLManager.shared.queue.inDatabase { (db) in
            
            guard let rs = db.executeQuery(sql, withParameterDictionary: nil) else {
                return
            }
            
            while rs.next() {
                
                let obj : SLCurrency = SLCurrency()
                
                obj.name = rs.string(forColumn: "name")
                obj.code = rs.string(forColumn: "code")
                obj.updatetime = rs.string(forColumn: "updatetime")
                obj.exchange = rs.double(forColumn: "exchange")
                obj.query = rs.string(forColumn: "query")
                
                list.append(obj)
            }
        }
        return list
    }
    
    func updateSQL(sql : String) -> () {
        
        SLTmpSQLManager.shared.queue.inTransaction { (db, rollback) in
            
            db.executeStatements(sql)
        }
    }
    
}
