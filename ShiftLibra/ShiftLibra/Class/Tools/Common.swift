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

let homeTableViewPanGestureNotification = NSNotification.Name(rawValue: "homeTableViewPanGesture")

let homeTableViewSwipeGestureNotification = NSNotification.Name(rawValue: "homeTableViewSwipeGesture")

let swipeAnimationDuration = 0.125


let SPACING : CGFloat = 8

let SCREENH = UIScreen.main.bounds.height

let SCREENW = UIScreen.main.bounds.width

let smallFontSize = CGFloat(SCREENW <= 667 ? 15 : 17)

let normalFontSize = CGFloat(SCREENW <= 667 ? 20 : 21)

let settingFontSize = CGFloat(SCREENW <= 667 ? 25 : 27)

let topFontSize = CGFloat(SCREENW <= 667 ? 33 : 35)

let midFontSize = CGFloat(SCREENW <= 667 ? 29 : 31)

let bottomFontSize = CGFloat(SCREENW <= 667 ? 31 : 33)

let currencyListFont = CGFloat(SCREENW <= 667 ? 17 : 19)

let homeHeaderHight = (SCREENH - 20 - 20) / 11 + 20

let homeTableViewCellHight = (SCREENH - 20 - 20) / 11

let homeDetailTableViewCellHight = ((SCREENH - 20 - 20) / 11) * 8 / 9

let lineHight = CGFloat(1.5)

let labSpace = SCREENW <= 667 ? 35 : 40

func RGB(R : CGFloat, G : CGFloat, B : CGFloat, alpha : CGFloat) -> (UIColor) {
//    return UIColor(colorLiteralRed: Float(R / 255), green: Float(G / 255), blue: Float(B / 255), alpha: Float(alpha))
    
    return UIColor(red: CGFloat(R / 255), green: CGFloat(G / 255), blue: CGFloat(B / 255), alpha: CGFloat(alpha))
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



//let top_left_bgColor       = RGB(R: 27, G: 162, B: 240, alpha: 1)
//
//let top_left_textColor     = RGB(R: 227, G: 193, B: 148, alpha: 1)
//
//let top_right_bgColor      = RGB(R: 124, G: 138, B: 139, alpha: 1)
//
//let top_right_textColor    = RGB(R: 0, G: 0, B: 10, alpha: 1)
//
//let bottom_left_bgColor    = RGB(R: 246, G: 232, B: 237, alpha: 1)
//
//let bottom_left_textColor  = RGB(R: 206, G: 158, B: 285, alpha: 1)
//
//let bottom_left_lineColor  = RGB(R: 213, G: 216, B: 200, alpha: 1)
//
//let bottom_right_bgColor   = RGB(R: 246, G: 239, B: 210, alpha: 1)
//
//let bottom_right_textColor = RGB(R: 211, G: 113, B: 11, alpha: 1)
//
//let bottom_right_lineColor = RGB(R: 235, G: 231, B: 203, alpha: 1)
//
//let mid_left_bgColor       = RGB(R: 243, G: 173, B: 165, alpha: 1)
//
//let mid_left_textColor     = RGB(R: 255, G: 245, B: 209, alpha: 1)
//
//let mid_left_lineColor     = RGB(R: 234, G: 215, B: 197, alpha: 1)
//
//let mid_right_bgColor      = RGB(R: 216, G: 216, B: 216, alpha: 1)
//
//let mid_right_textColor    = RGB(R: 244, G: 127, B: 82, alpha: 1)
//
//let mid_right_lineColor    = RGB(R: 184, G: 187, B: 188, alpha: 1)


func randomColor() -> UIColor{

    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    
    return RGB(R: r, G: g, B: b, alpha: 1)
}
