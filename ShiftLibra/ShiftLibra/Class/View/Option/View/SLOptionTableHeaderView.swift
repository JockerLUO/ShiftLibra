//
//  SLOptionTableHeaderView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/31.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLOptionTableHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() -> () {
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.contentView).offset(16)
            
            make.centerY.equalTo(self.contentView)
        }
                
    }

    lazy var label : UILabel = UILabel(text: "☆123", textColor: UIColor.red, fontSize: smallFontSize)
}
