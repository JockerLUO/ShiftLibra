//
//  SLHomeHeaderRightView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/29.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeHeaderRightView: UIView {

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        
        path.move(to:CGPoint(x: 0, y: 10))
        
        path.addLine(to: CGPoint(x: 30, y: self.bounds.height / 2))
        
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height - 10))
        
        path.lineWidth = 0
        
        top_left_bgColor.setFill()
        
        path.fill(with: .normal, alpha: 1)
        
    }

    

}
