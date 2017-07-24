//
//  Extension + UIImage.swift
//  weibo
//
//  Created by LUO on 2017/6/30.
//  Copyright © 2017年 luo. All rights reserved.
//

import UIKit
/*
 - 通过代码方式来解决图片拉伸问题
 */
extension UIImage {
    // 通过class 来修饰类方法
    class func resizableImage(named : String) -> UIImage{
        // 图片
        let image = UIImage(named: named)!
        // 设置端盖的值
        let top = image.size.height * 0.5
        let left = image.size.width * 0.5
        let bottom = image.size.height * 0.5
        let right = image.size.width * 0.5
        let edgeInsets =  UIEdgeInsetsMake(top, left, bottom, right)
        // 拉伸图片
        let newImage = image.resizableImage(withCapInsets: edgeInsets)
        return newImage
    }
    
    class func getScreenSnap() -> UIImage? {
        
        let window = UIApplication.shared.keyWindow!
        
        UIGraphicsBeginImageContext(UIScreen.main.bounds.size)
        
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        
        let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return img
    }
    
    func changeImageScale(maxW : CGFloat) -> UIImage {
        
        let imgH : CGFloat = self.size.height
        
        let imgW : CGFloat = self.size.width
        
        if imgW < maxW {
            return self
        }
        
        let maxH = maxW * imgW / imgH
        
        UIGraphicsBeginImageContext(CGSize(width: maxW, height: maxH))
        
        self.draw(in: CGRect(x: 0, y: 0, width: maxW, height: maxH))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return img
        
    }
    
}

