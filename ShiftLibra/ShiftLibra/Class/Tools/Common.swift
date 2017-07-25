//
//  Common.swift
//  weibo
//
//  Created by LUO on 2017/6/29.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit

//微博相关信息
let APPKEY = "4253856835"
let APPSECRET = "6ca345a17bc73cc75afc91ed8270cc53"

let REDIRECT_URI = "https://sns.whalecloud.com/sina2/callback"

let SPACING : CGFloat = 8

let SCREENH = UIScreen.main.bounds.height

let SCREENW = UIScreen.main.bounds.width

func themeColor() -> (UIColor) {
    return UIColor.orange
}

let smallFontSize = CGFloat(17)

let normalFontSize = CGFloat(32)

let largeFontSize = CGFloat(35)

let topFontSize = CGFloat(42)

let midFontSize = CGFloat(32)

let bottomFontSize = CGFloat(35)

let homeTableViewCellHight = SCREENH - 20












func RGB(R : CGFloat, G : CGFloat, B : CGFloat, alpha : CGFloat) -> (UIColor) {
    return UIColor(colorLiteralRed: Float(R / 255), green: Float(G / 255), blue: Float(B / 255), alpha: Float(alpha))
}

let top_left_bgColor       = RGB(R: 32, G: 31, B: 37, alpha: 1)

let top_left_textColor     = RGB(R: 195, G: 90, B: 83, alpha: 1)

let top_right_bgColor      = RGB(R: 124, G: 138, B: 139, alpha: 1)

let top_right_textColor    = RGB(R: 238, G: 178, B: 95, alpha: 1)

let bottom_left_bgColor    = RGB(R: 47, G: 50, B: 62, alpha: 1)

let bottom_left_textColor  = RGB(R: 246, G: 249, B: 253, alpha: 1)

let bottom_right_bgColor   = RGB(R: 136, G: 152, B: 153, alpha: 1)

let bottom_right_textColor = RGB(R: 243, G: 239, B: 222, alpha: 1)

let mid_left_bgColor       = RGB(R: 31, G: 33, B: 40, alpha: 1)

let mid_left_textColor     = RGB(R: 245, G: 248, B: 250, alpha: 1)

let mid_right_bgColor      = RGB(R: 98, G: 110, B: 111, alpha: 1)

let mid_right_textColor    = RGB(R: 242, G: 239, B: 225, alpha: 1)

let homeTable_bgcolor      = RGB(R: 92, G: 104, B: 104, alpha: 1)

let detailTable_bgcolor    = RGB(R: 147, G: 162, B: 163, alpha: 1)

// 随机颜色
func randomColor() -> UIColor{
    // 随机数
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    
    return RGB(R: r, G: g, B: b, alpha: 1)
}
