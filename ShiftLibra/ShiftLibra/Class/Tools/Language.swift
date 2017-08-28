//
//  Language.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/16.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

var country = "China" {
    
    didSet {
        
        customExchange = country == "China" ? "设定自定义汇率" : "Set Custom Rate"
        
        customCurrency = country == "China" ? "自定义" : "CUSTOM RATES"
        
        updatedTime = country == "China" ? "已更新" : "Updated"
        
        btnShiftText = country == "China" ? "切换" : "Swap"
        
        btnOtherText = country == "China" ? "选择其他" : "Choose Currency"
        
        btnCancelText = country == "China" ? "取消" : "Cancel"
        
        btnFinishText = country == "China" ? "完成" : "Finish"
        
        indexHotText = country == "China" ? "☆热门" : "☆POPULAR"

        indexcustomExchangeText = country == "China" ? "自定义汇率" : "Set Custom Rate"

        alertVCTitle = country == "China" ? "提示" : "Info"

        alertVCMessage = country == "China" ? "由于服务器原因未收录此货币,汇率信息已过期\n您是否仍要查询此货币汇率" : "The currency has not been credited due to server reasons, Do you still want to check this currency exchange rate?"

        confirmTitle = country == "China" ? "确定" : "Done"
        
        alertVCLangangeMessage = country == "China" ? "当前所在地为国外是否切换为英语" : "Now in China whether to switch to Chinese"

        alertVCZWDMessage = country == "China" ? "由于津巴布韦元汇率不稳未收录" : "As the Zimbabwe dollar exchange rate instability is not included"
        
        searchResultsText = country == "China" ? " " : "search results"
    }
    
}

private(set) var customExchange = "设定自定义汇率"

private(set) var customCurrency = "★"

private(set) var updatedTime = "已更新"

private(set) var btnShiftText = "切换"

private(set) var btnOtherText = "选择其他"

private(set) var btnCancelText = "取消"

private(set) var btnFinishText = "完成"

private(set) var indexHotText = "☆热门"

private(set) var searchResultsText = "搜索结果"

private(set) var indexcustomExchangeText = "自定义汇率"

private(set) var alertVCTitle = "提示"

private(set) var alertVCMessage = "由于服务器原因未收录此货币,汇率信息已过期,您是否仍要查询此货币汇率"

private(set) var confirmTitle = "确定"

private(set) var alertVCLangangeMessage = "当前所在地为国外是否切换为英语"

private(set) var alertVCZWDMessage = "由于津巴布韦元汇率不稳未收录"
