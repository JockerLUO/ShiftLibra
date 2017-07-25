//
//  SLHomeHeaderView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/24.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() -> () {
        
        addSubview(bgView)
        
        bgView.snp.makeConstraints { (make) in
            
            make.right.top.bottom.equalTo(self)
            make.left.equalTo(self.snp.centerX)
        }
        
        
        self.backgroundColor = top_left_bgColor
        
        bgView.backgroundColor = top_right_bgColor
        
        
        
        self.addSubview(labLeft)
        
        labLeft.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(self)
            
            make.right.equalTo(self.snp.centerX).offset(-30)
        }
        
        self.addSubview(labRight)
        
        labRight.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(self)
            
            make.left.equalTo(self.snp.centerX).offset(30)
        }
        
        
    }
    
    lazy var bgView : UIView = UIView()
    
    lazy var labLeft: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "CNY"
        
        lab.font = UIFont.systemFont(ofSize: topFontSize)
        
        lab.textColor = top_left_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var labRight: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "USD"
        
        lab.font = UIFont.systemFont(ofSize: topFontSize)
        
        lab.textColor = top_right_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
    
}
