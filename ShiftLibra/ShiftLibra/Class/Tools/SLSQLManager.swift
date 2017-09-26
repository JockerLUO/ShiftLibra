//
//  SLSQLManager.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import FMDB

// 数据库名
private let dbName = "currency.db"

class SLSQLManager{
    
    // 全局访问点
    static let shared: SLSQLManager = SLSQLManager()
    
    static let sharedTmp : SLSQLManager = SLSQLManager(istmp: true)
    
    // 串行队列
    let queue: FMDatabaseQueue
    
    // 路径
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
    
    let tmpPath = Bundle.main.path(forResource: "currency_tmp.db", ofType: nil) ?? ""

    
    // 类的构造函数
    private init() {
        
        queue = FMDatabaseQueue(path: path)
        
        createTable()
    }
    
    private init(istmp : Bool ) {
        
        queue = FMDatabaseQueue(path: tmpPath)
        
        createTable()
    }
    
    // 创建表
    private func createTable(){
        
        let file = Bundle.main.path(forResource: "currency.db", ofType: nil)!
        
        let sql = try! String(contentsOfFile: file)
        
        queue.inDatabase { (db) in
            
            if db.executeStatements(sql) == true{
                
                //                print("创建表成功")
                
            } else {
                
                print("创建表失败")
            }
        }
    }
    
    
}

extension SLSQLManager{
    
    func insertToSQL(dataList : [SLCurrency]) -> () {
        
        queue.inTransaction({ (db, rollback) in
            
            for obj in dataList {
                
                let sql = "INSERT INTO T_Currency (name,code) VALUES('\(obj.name!)','\(obj.code!)')"
                
                db.executeStatements(sql)
            }
            
        })
    }
    
    func insertToSQL(sql : String) -> () {
        
        queue.inTransaction({ (db, rollback) in
                
                db.executeStatements(sql)
        })
    }
    
    func orderSQL() -> [String : [SLCurrency]]? {
        
        var list : [String: [SLCurrency]] = [String : [SLCurrency]]()
        
        let sql = "SELECT * FROM T_Currency ORDER BY code AND query != 'customize';"
        
        queue.inDatabase { (db) -> Void in
            
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
                obj.name_English = rs.string(forColumn: "name_English")
                
                let mainString = obj.code ?? "CNY"
                
                let index = mainString.index(mainString.startIndex, offsetBy: 1)
                
                let key = String(mainString[..<index])
                
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
        
        queue.inDatabase { (db) in
            
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
                obj.name_English = rs.string(forColumn: "name_English")
                
                list.append(obj)
            }
        }
        
        return list
    }
    
    func updateSQL(sql : String) -> () {
        
        queue.inTransaction { (db, rollback) in
            
            db.executeStatements(sql)
        }
    }
    
}
