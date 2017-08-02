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
private let dbName = "home.db"

class WBSQLManager{
    
    // 全局访问点
    static let share: WBSQLManager = WBSQLManager()
    
    // 串行队列
    let queue: FMDatabaseQueue
    
    // 路径
    let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent(dbName)
    // 类的构造函数
    init() {
        print(path)
        // 看本地是否有数据库 如果有直接打开 如果没有创建数据库然后打开 数据库一般已经打开 不在关闭
        queue = FMDatabaseQueue(path: path)
        createTable()
    }
    
    // 创建表
    private func createTable(){
        // 本地文件
        let file = Bundle.main.path(forResource: "db.sql", ofType: nil)!
        // 准备sql(通过文件获取文件中的字符串)
        let sql = try! String(contentsOfFile: file)
        queue.inDatabase { (db) in
            // 执行多条sql
            if db.executeStatements(sql) == true{
                print("创建表成功")
            }else{
                print("创建表失败")
            }
        }
    }
    
    
}

extension WBSQLManager{
    // 通过指定的sql语句查询数据库 返回 字典数据
    // 查2
    func executeRecodeSet(sql: String) -> [[String: Any]]{
        // 创建一个临时可变的空数组
        var tempList:[[String: Any]] = [[String: Any]]()
        
        // 执行sql
        WBSQLManager.share.queue.inDatabase { (db) in
            do{
                let resultSet = try db.executeQuery(sql, values: nil)
                // 遍历每一行配合while循环使用(遍历每一行)
                while resultSet.next(){
                    var dict:[String: Any] = [String: Any]()
                    // 遍历每一列
                    for i in 0..<resultSet.columnCount {
                        let name = resultSet.columnName(for: i)!
                        let key = resultSet.object(forColumnIndex: i)
                        dict[name] = key
                    }
                    
                    //                    // 添加到数组中
                    tempList.append(dict)
                }
                
            }catch{
                print(error)
            }
        }
        return tempList
    }
}

