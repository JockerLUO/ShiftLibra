//
//  SLHomeCell.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/23.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import FoldingCell
import SnapKit

class SLHomeCell: FoldingCell {
    
    static let detailID = "detailID"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemCount = 3
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        contentView.addSubview(fgView)
        
        foregroundView = fgView
        
        foregroundView.snp.makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(homeTableViewCellHight)
        }
        
        foregroundViewTop = NSLayoutConstraint(item: foregroundView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        addConstraint(foregroundViewTop)
        
        contentView.addSubview(ctView)
        
        containerView = ctView
        
        containerView.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(foregroundView.snp.left)
            make.height.equalTo(homeDetailTableViewCellHight * 10)
        }
        
        containerViewTop = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (homeTableViewCellHight))
        
        addConstraint(containerViewTop)
        
        
        foregroundView.addSubview(bgView)
        
        bgView.snp.makeConstraints { (make) in
            
            make.right.top.bottom.equalTo(foregroundView)
            make.left.equalTo(foregroundView.snp.centerX)
        }
        
        
        fgView.backgroundColor = bottom_left_bgColor
        
        bgView.backgroundColor = bottom_right_bgColor
        
        
        contentView.addSubview(detailView)
        
        detailView.snp.makeConstraints { (make) in
            
            make.top.equalTo(homeTableViewCellHight)
            
            make.left.right.equalTo(contentView)
            
            make.bottom.equalTo(contentView)
        }
        
        foregroundView.addSubview(labLeft)
        
        labLeft.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(foregroundView)
            
            make.right.equalTo(foregroundView.snp.centerX).offset(-labSpace)
        }
        
        foregroundView.addSubview(labRight)
        
        labRight.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(foregroundView)
            
            make.left.equalTo(foregroundView.snp.centerX).offset(labSpace)
        }
        
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {

        return 0.01
    }
    
    lazy var fgView: RotatedView! = {
        
        let view = RotatedView()
        
        return view
    }()
    
    lazy var ctView: UIView = {
        
        let view = UIView()
        
        view.isHidden = true
        
        return view
    }()
    
    lazy var bgView : UIView = UIView()

    
    lazy var labLeft: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "123"
        
        lab.font = UIFont.systemFont(ofSize: bottomFontSize)
        
        lab.textColor = bottom_left_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var labRight: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "321"
        
        lab.font = UIFont.systemFont(ofSize: bottomFontSize)
        
        lab.textColor = bottom_right_textColor
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var detailView: SLHomeDetailView = SLHomeDetailView()
}



