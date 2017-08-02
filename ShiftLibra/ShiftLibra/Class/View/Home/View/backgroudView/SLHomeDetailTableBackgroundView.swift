//
//  SLHomeDetailTableBackgroundView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/30.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeDetailTableBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = mid_right_bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        
        path.move(to:CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: self.center.x, y: 0))
        
        path.addLine(to: CGPoint(x: self.center.x, y: self.bounds.height))
        
        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        
        path.lineWidth = 0
        
        mid_left_bgColor.setFill()
        
        path.fill(with: .normal, alpha: 1)
    }
}
