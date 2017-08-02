//
//  Common.swift
//  weibo
//
//  Created by LUO on 2017/6/29.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit

//API相关信息
let APIKEY = "241d0f39cb5bb8d2c7cc85d3ea0d58cb"

let API_QUERY_URL = "http://op.juhe.cn/onebox/exchange/query"

let API_LIST_URL = "http://op.juhe.cn/onebox/exchange/list"

let API_CURRENCY_URL = "http://op.juhe.cn/onebox/exchange/currency"

let SPACING : CGFloat = 8

let SCREENH = UIScreen.main.bounds.height

let SCREENW = UIScreen.main.bounds.width

let smallFontSize = CGFloat(17)

let normalFontSize = CGFloat(20)

let settingFontSize = CGFloat(25)

let topFontSize = CGFloat(33)

let midFontSize = CGFloat(29)

let bottomFontSize = CGFloat(31)

let homeHeaderHight = (SCREENH - 20 - 20) / 11 + 20

let homeTableViewCellHight = (SCREENH - 20 - 20) / 11

let homeDetailTableViewCellHight = ((SCREENH - 20 - 20) / 11) * 8 / 10

let labSpace = 50

func RGB(R : CGFloat, G : CGFloat, B : CGFloat, alpha : CGFloat) -> (UIColor) {
    return UIColor(colorLiteralRed: Float(R / 255), green: Float(G / 255), blue: Float(B / 255), alpha: Float(alpha))
}

let top_left_bgColor       = RGB(R: 32, G: 31, B: 37, alpha: 1)

let top_left_textColor     = RGB(R: 195, G: 90, B: 83, alpha: 1)

let top_right_bgColor      = RGB(R: 124, G: 138, B: 139, alpha: 1)

let top_right_textColor    = RGB(R: 238, G: 178, B: 95, alpha: 1)

let bottom_left_bgColor    = RGB(R: 47, G: 50, B: 62, alpha: 1)

let bottom_left_textColor  = RGB(R: 246, G: 249, B: 253, alpha: 1)

let bottom_left_lineColor  = RGB(R: 64, G: 67, B: 68, alpha: 1)

let bottom_right_bgColor   = RGB(R: 136, G: 152, B: 153, alpha: 1)

let bottom_right_textColor = RGB(R: 243, G: 239, B: 222, alpha: 1)

let bottom_right_lineColor = RGB(R: 147, G: 162, B: 163, alpha: 1)

let mid_left_bgColor       = RGB(R: 31, G: 33, B: 40, alpha: 1)

let mid_left_textColor     = RGB(R: 245, G: 248, B: 250, alpha: 1)

let mid_left_lineColor     = RGB(R: 24, G: 26, B: 34, alpha: 1)

let mid_right_bgColor      = RGB(R: 98, G: 110, B: 111, alpha: 1)

let mid_right_textColor    = RGB(R: 242, G: 239, B: 225, alpha: 1)

let mid_right_lineColor    = RGB(R: 78, G: 92, B: 92, alpha: 1)

func randomColor() -> UIColor{

    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    
    return RGB(R: r, G: g, B: b, alpha: 1)
}
