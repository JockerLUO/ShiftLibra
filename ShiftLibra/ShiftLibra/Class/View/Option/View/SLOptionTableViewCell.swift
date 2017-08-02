//
//  SLOptionTableViewCell.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/31.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLOptionTableViewCell: UITableViewCell {
    
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
    
    func setupUI() -> () {
        
        contentView.addSubview(labCode)
        
        labCode.snp.makeConstraints { (make) in
            
            make.left.equalTo(20)
            
            make.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(labName)
        
        labName.snp.makeConstraints { (make) in
            
            make.left.equalTo(70)
            
            make.centerY.equalTo(contentView)
        }
        
        labName.textColor = UIColor.white
        
    }
    
    lazy var labCode : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "CNY"
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var labName : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "人民币"
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.sizeToFit()
        
        return lab
    }()
}
