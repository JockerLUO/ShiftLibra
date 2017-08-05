//
//  SLHomeHeaderBackgroundView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/30.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeHeaderBackgroundView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = top_right_bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        
        path.move(to:CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: self.center.x, y: 0))
        
        path.addLine(to: CGPoint(x: self.center.x, y: 10))
        
        path.addLine(to: CGPoint(x: self.center.x + 20, y: self.bounds.height * 0.5))

        path.addLine(to: CGPoint(x: self.center.x, y: self.bounds.height - 10))

        path.addLine(to: CGPoint(x: self.center.x, y: self.bounds.height))

        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        
        path.lineWidth = 0
        
        top_left_bgColor.setFill()
        
        path.fill(with: .normal, alpha: 1)
    }
    
    
    
    
}
