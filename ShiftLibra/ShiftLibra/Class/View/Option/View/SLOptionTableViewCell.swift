//
//  SLOptionTableViewCell.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/31.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLOptionTableViewCell: UITableViewCell {
    
    var currency : SLCurrency? {
        
        didSet {
            
            labName.text = country == "China" ? currency?.name : currency?.name_English
            
            labCode.text = currency?.code
            
            if currency?.query == "expire" {
                
                labLock.text = "🔒"
                
            } else if currency?.query == "minority" {
                
                labLock.text = "🔐"
                
            } else {
                
                labLock.text = ""
            }
            
            
        }
    }
    
    var optionType : SLOptionCurrencyType = .to {
        
        didSet {
            
            switch optionType {
                
            case .from:
                
                labName.textColor = bottom_left_textColor
                
                labCode.textColor = top_left_textColor
                
                lineView.backgroundColor = bottom_left_lineColor
                
            case .to:
                
                labName.textColor = bottom_right_textColor
                
                labCode.textColor = top_right_textColor
                
                lineView.backgroundColor = RGB(R: 96, G: 113, B: 114, alpha: 1)
        
            }
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    fileprivate func setupUI() -> () {
        
        contentView.addSubview(labCode)
        
        labCode.snp.makeConstraints { (make) in
            
            make.left.equalTo(20)
            
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(labName)
        
        labName.snp.makeConstraints { (make) in
            
            make.left.equalTo(80)
            
            make.centerY.equalTo(contentView)            
        }
        
        labName.textColor = UIColor.white
        
        contentView.addSubview(labLock)
        
        labLock.snp.makeConstraints { (make) in
            
            make.right.equalTo(-16)
            
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(lineView)
        
        lineView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(contentView)
            
            make.height.equalTo(0.5)
        }
        
        lineView.backgroundColor = UIColor.white
    }
    
    fileprivate lazy var labCode : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "CNY"
        
        lab.font = UIFont.systemFont(ofSize: currencyListFont)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    fileprivate lazy var labName : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "人民币"
        
        lab.font = UIFont.systemFont(ofSize: currencyListFont)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    fileprivate lazy var labLock : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "🔒"
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    fileprivate lazy var lineView : UIView = UIView()
}
