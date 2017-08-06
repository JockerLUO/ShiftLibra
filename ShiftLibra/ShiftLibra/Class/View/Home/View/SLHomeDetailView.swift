//
//  SLHomeDetailView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/24.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeDetailView: UIView {
    
    static let detailID = "detailID"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() -> () {
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.rowHeight = homeDetailTableViewCellHight
        
        tableView.bounces = false
        
        tableView.separatorInset = .zero
        
        tableView.separatorStyle = .none
        
        tableView.isUserInteractionEnabled = false
        
        tableView.register(SLHomeDetailCell.self, forCellReuseIdentifier:SLHomeDetailView.detailID)
    }
    
    lazy var tableView : UITableView = {
        
        let tableView = UITableView()
                
        return tableView
    }()
    
}

extension SLHomeDetailView : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SLHomeDetailView.detailID, for: indexPath)
        
        cell.selectionStyle = .none
        
        return cell
        
        
    }
    
    
}
