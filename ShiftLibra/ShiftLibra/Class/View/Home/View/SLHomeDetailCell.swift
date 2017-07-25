//
//  SLHomeDetailCell.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/24.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeDetailCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() -> () {
        
        contentView.addSubview(bgView)
        
        bgView.snp.makeConstraints { (make) in
            
            make.right.top.bottom.equalTo(contentView)
            make.left.equalTo(contentView.snp.centerX)
        }
        
        
        contentView.backgroundColor = mid_left_bgColor
        
        bgView.backgroundColor = mid_right_bgColor
        
        
        
        contentView.addSubview(labLeft)
        
        labLeft.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(contentView)
            
            make.right.equalTo(contentView.snp.centerX).offset(-30)
        }
        
        contentView.addSubview(labRight)
        
        labRight.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(contentView)
            
            make.left.equalTo(contentView.snp.centerX).offset(30)
        }

        
    }
    
    lazy var bgView : UIView = UIView()

    lazy var labLeft: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "456"
        
        lab.font = UIFont.systemFont(ofSize: midFontSize)
        
        lab.textColor = mid_left_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var labRight: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "654"
        
        lab.font = UIFont.systemFont(ofSize: midFontSize)
        
        lab.textColor = mid_right_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
}
