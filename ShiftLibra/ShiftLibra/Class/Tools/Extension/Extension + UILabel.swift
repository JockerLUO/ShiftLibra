//
//  Extension + UILabel.swift
//  weibo
//
//  Created by LUO on 2017/6/29.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String?, textColor: UIColor, fontSize: CGFloat, maxWidth: CGFloat = 0){
        self.init()
        // 设置文字
        self.text = text
        // 字体颜色
        self.textColor = textColor
        // 字体大小
        self.font = UIFont.systemFont(ofSize: fontSize)
        // 判断maxWidth是否大于0
        if maxWidth > 0 {
            // 如果你设置最大宽度 认为就是需要换行
            self.preferredMaxLayoutWidth = maxWidth
            self.numberOfLines = 0
        }
    }
}
