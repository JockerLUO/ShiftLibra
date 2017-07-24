//
//  Extension + UIButton.swift
//  weibo
//
//  Created by LUO on 2017/6/29.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit

extension UIButton {
    
    /*
     文字 和 背景图片
     */
    convenience init(title: String?, fontSize: CGFloat, normalColor: UIColor, highlightedColor: UIColor, backgroundImgName: String, target: Any?, action: Selector){
        self.init()
        self.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(normalColor, for: UIControlState.normal)
        self.setTitleColor(highlightedColor, for: UIControlState.highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setBackgroundImage(UIImage.resizableImage(named: backgroundImgName), for: UIControlState.normal)
        
    }
}
