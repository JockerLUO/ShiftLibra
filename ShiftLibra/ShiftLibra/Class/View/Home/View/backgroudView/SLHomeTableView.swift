//
//  SLHomeTableView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/30.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = bottom_right_bgColor
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
        
        bottom_left_bgColor.setFill()
        
        path.fill(with: .normal, alpha: 1)
    }

}
