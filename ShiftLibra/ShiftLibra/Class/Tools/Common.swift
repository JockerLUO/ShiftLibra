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

let smallFontSize = CGFloat(10)

let normalFontSize = CGFloat(14)

let largeFontSize = CGFloat(17)


func RGB(R : CGFloat, G : CGFloat, B : CGFloat, alpha : CGFloat) -> (UIColor) {
    return UIColor(colorLiteralRed: Float(R / 255), green: Float(G / 255), blue: Float(B / 255), alpha: Float(alpha))
}

// 随机颜色
func randomColor() -> UIColor{
    // 随机数
    let r = CGFloat(arc4random()%256)
    let g = CGFloat(arc4random()%256)
    let b = CGFloat(arc4random()%256)
    
    return RGB(R: r, G: g, B: b, alpha: 1)
}
