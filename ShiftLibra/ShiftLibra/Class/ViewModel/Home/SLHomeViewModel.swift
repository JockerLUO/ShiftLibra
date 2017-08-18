//
//  SLHomeViewModel.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/1.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeViewModel: NSObject {
    
    enum SLHomeViewModelType : Int {
        case to = 1101
        case from = 1102
    }
    
    lazy var toMoneyList : [String] = [String]()
    
    lazy var fromMoneyList : [String] = [String]()
    
    lazy var fromMoneyDetailList : [[String]] = [[String]]()
    
    lazy var toMoneyDetailList : [[String]] = [[String]]()
    
    var fromCurrency : SLCurrency? {
        
        didSet {
            
            setCurrency(currency: fromCurrency!, type: .from)
        }
    }
    
    var toCurrency : SLCurrency? {
        
        didSet {
            
            setCurrency(currency: fromCurrency!, type: .from)
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
        
        if SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';").count > 0 {
            
            let queryList = SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
            
            fromCurrency = queryList[0]
            
            toCurrency = queryList[1]
            
        } else {
            
            let list = SLSQLManager.sharedTmp.selectSQL(sql: "SELECT * FROM T_Currency WHERE query='query';")
            
            fromCurrency = list[0]
            
            toCurrency = list[1]
        }
        
        
        
        exchange = (fromCurrency?.exchange)! / (toCurrency?.exchange)!
        
        changeMonyeAndDigits()
    }
    
    fileprivate func changeMonyeAndDigits() -> () {
        
        
        if multiple > 1e10 {
            
            multiple = 1e10
            
            return
        }
        
        if multiple < 10 {
            
            multiple = 10
            
            return
        }
        
        toMoneyList.removeAll()
        
        fromMoneyList.removeAll()
        
        toMoneyDetailList.removeAll()
        
        fromMoneyDetailList.removeAll()
        
        for i in 1...10 {
            
            let fromMoney = multiple * Double(i)
            
            let toMoney = multiple * exchange * Double(i)
            
            fromMoneyList.append(getMoneyInfo(money: fromMoney))
            
            toMoneyList.append(getMoneyInfo(money: toMoney))
            
            var fromMoneyDetailListTmp = [String]()
            
            var toMoneyDetailListTmp = [String]()
            
            for n in 1...10 {
                
                let fromMoneyDetail = multiple * (Double(i) + Double(n) * 0.1)
                
                let toMoneyDetail = multiple * exchange * (Double(i) + Double(n) * 0.1)
                
                fromMoneyDetailListTmp.append(getMoneyInfo(money: fromMoneyDetail))
                
                toMoneyDetailListTmp.append(getMoneyInfo(money: toMoneyDetail))
            }
            
            fromMoneyDetailList.append(fromMoneyDetailListTmp)
            
            toMoneyDetailList.append(toMoneyDetailListTmp)
        }
        
    }
    
    fileprivate func getMoneyInfo(money : Double) -> (String) {
        
        var str : String = ""
        
        var moneyDigits : String = ""
        
        var afterMoney : Double = 1.0
        
        getDigits(money: money, closure: { (alterMoney, digit) in
            
            afterMoney = alterMoney
            
            moneyDigits = digit
        })
        
        if afterMoney < 10 {
            
            afterMoney = (String(format: "%.2f", afterMoney) as NSString).doubleValue
            
        } else {
            
            afterMoney = Double(Int(afterMoney))
        }
        
        if afterMoney >= 10 {
            
            if afterMoney > 1000 {
                
                if Int(afterMoney) % 1000 == 0 {
                    
                     str = "\(Int(afterMoney) / 1000),000\(moneyDigits)"
                    
                } else if Int(afterMoney) % 1000 < 10 {
                    
                    str = "\(Int(afterMoney) / 1000),00\(Int(afterMoney) % 1000)\(moneyDigits)"
                    
                } else if Int(afterMoney) % 1000 < 100 {
                    
                    str = "\(Int(afterMoney) / 1000),0\(Int(afterMoney) % 1000)\(moneyDigits)"
                    
                } else {
                    
                    str = "\(Int(afterMoney) / 1000),\(Int(afterMoney) % 1000)\(moneyDigits)"
                }
                
            } else {
                
                str = "\(Int(afterMoney))\(moneyDigits)"
            }
            
        } else {
            
            str = "\(afterMoney)\(moneyDigits)"
        }
        
        return str
    }
    
    fileprivate func getDigits(money : Double, closure: (Double, String)->()) -> () {
        
        var alterMoney : Double
        
        var digit : String
        
        
        if money >= 1e10 {
            
            alterMoney = money / 1e9
            
            digit = "B"
            
        } else if money >= 1e7 {
            
            alterMoney = money / 1e6
            
            digit = "M"
            
        } else if money >= 1e5 {
            
            alterMoney = money / 1e3
            
            digit = "K"
        } else {
            
            alterMoney = money
            
            digit = ""
        }
        
        closure(alterMoney, digit)
    }
    
    fileprivate func setCurrency(currency : SLCurrency ,type : SLHomeViewModelType) -> () {
        
        if setCurrencyUpdatetime(currency: currency, type: type) {
            
            return
        }
        
        if currency.exchange == 0 {
            
            currency.exchange = 1.0
            
            getNewexchangeFromNetwoking(currency: currency, type: type)
        }
        
        exchange = (fromCurrency?.exchange)! / (toCurrency?.exchange)!
        
        multiple = 1.0
    }
    
    func setCurrencyUpdatetime(currency : SLCurrency ,type : SLHomeViewModelType) -> (Bool) {
        
        let dataFormatterStr : String = "YYYY-MM-dd HH:mm:ss"
        
        let dateF = DateFormatter()
        
        dateF.dateFormat = dataFormatterStr
        
        let createdTime = dateF.date(from: currency.updatetime!)
        
        guard let time = createdTime else {
            
            return false
        }
        
        let s = Int(-time.timeIntervalSinceNow)
        
        if currency.query == "minority" && s > 60 * 60 * 24 * 7 {
            
            getNewexchangeFromNetwoking(currency: currency, type: type)
            
            return true
        }
        
        return false
    }
    

    
    fileprivate func getNewexchangeFromNetwoking(currency : SLCurrency ,type : SLHomeViewModelType) -> () {
        
        SLNetworkingTool.shared.getCurrency(from: "CNY", to: (currency.code)!, success: { (request) in
            
            guard let data = request as? [String : Any] else {
                
                return
            }
            
            if let reason = data["reason"] as? String {
                
                if reason != "查询成功!" {
                    
                    print(reason)
                    
                    return
                }
            }
            
            guard let list = (data["result"] as? [Any]) else {
                
                return
            }
            
            let dic = list[0] as! [String : Any]
            
            let alterCurrency = SLCurrency()
            
            alterCurrency.name = currency.name
            
            alterCurrency.code = currency.code
            
            alterCurrency.exchange = ((dic["exchange"] as! NSString?)?.doubleValue)!
            
            alterCurrency.updatetime = dic["updateTime"] as? String
            
            let sql : String = "UPDATE T_Currency set exchange=\(alterCurrency.exchange),query='minority',updatetime='\(alterCurrency.updatetime ?? "")' WHERE name='\(alterCurrency.name ?? "")';"
            
            SLSQLManager.shared.updateSQL(sql: sql)
            if type == .to {
                
                self.toCurrency = alterCurrency
                
            } else {
                
                self.fromCurrency = alterCurrency
            }
            
        }, failure: { (error) in
            
            print("出错了",error)
        })
    }
}
