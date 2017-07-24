//
//  Extension.swift
//  weibo
//
//  Created by LUO on 2017/6/30.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    // 图片名 名字  target action
    convenience init(imgName: String?, title: String?, target: Any?, action: Selector){
        
        // 实例化一个按钮
        let button = UIButton()
        // 监听事件
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        if let img = imgName {
            // 图片
            button.setImage(UIImage(named:img), for: UIControlState.normal)
            button.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        if let tit = title {
            // 文字
            button.setTitle(tit, for: UIControlState.normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            button.setTitleColor(UIColor.orange, for: UIControlState.highlighted)
        }
        
        button.sizeToFit()
        
        // 调用指定构造函数完成实例化
        self.init(customView: button)
        
    }
    
    
    
    
}
