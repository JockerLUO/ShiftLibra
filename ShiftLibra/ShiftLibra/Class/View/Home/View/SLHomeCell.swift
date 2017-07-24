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
            make.height.equalTo(SCREENH / 11)
        }
        
        foregroundViewTop = NSLayoutConstraint(item: foregroundView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        addConstraint(foregroundViewTop)
        
        contentView.addSubview(ctView)
        
        containerView = ctView
        
        containerView.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(foregroundView.snp.left)
            make.height.equalTo(SCREENH  * 9 / 11 )
        }
        
        containerViewTop = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (SCREENH / 11))
        
        addConstraint(containerViewTop)
        
        contentView.addSubview(detailTableView)
        
//        detailTableView.delegate = self
//        
//        detailTableView.dataSource = self
        
        detailTableView.snp.makeConstraints { (make) in
            
            make.top.equalTo(SCREENH / 11)
            
            make.left.right.equalTo(contentView)
            
            make.bottom.equalTo(contentView)
        }
        
        foregroundView.addSubview(labLeft)
        
        labLeft.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(foregroundView)
            
            make.centerX.equalTo(foregroundView.snp.centerX).offset(-30)
        }
        
        foregroundView.addSubview(labRight)
        
        labRight.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(foregroundView)
            
            make.centerX.equalTo(foregroundView.snp.centerX).offset(30)
        }
        
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
//        let durations = [0.33, 0.26, 0.26] // timing animation for each view
//        return durations[itemIndex]
        return 0.05
    }
    
    lazy var fgView: RotatedView! = {
        
        let view = RotatedView()
        
        view.backgroundColor = randomColor()
        
        return view
    }()
    
    lazy var ctView: UIView = {
        
        let view = UIView()
        
        view.isHidden = true
        
        return view
    }()
    
    lazy var labLeft: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "123"
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.textColor = UIColor.darkText
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var labRight: UILabel = {
        
        let lab = UILabel()
        
        lab.text = "321"
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.textColor = UIColor.darkText
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var detailTableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.rowHeight = (SCREENH * 9 / 11) / 10
        
        tableView.bounces = false
        
        tableView.register(SLHomeCell.self, forCellReuseIdentifier: detailID)

        return tableView
    }()
}

extension SLHomeCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:SLHomeCell.detailID , for: indexPath)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
}



