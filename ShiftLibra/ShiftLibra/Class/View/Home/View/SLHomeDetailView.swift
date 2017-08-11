//
//  SLHomeDetailView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/24.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

class SLHomeDetailView: UIView {
    
    var closure : (()->())?
    
    static let detailID = "detailID"
    
    var fromMoneyDetailList : [String]? {
        
        didSet {
            
            tableView.reloadData()
        }
    }

    var toMoneyDetailList : [String]? {
        
        didSet {
            
            tableView.reloadData()
        }
    }
    
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
        
//        tableView.isUserInteractionEnabled = false
        
        tableView.register(SLHomeDetailCell.self, forCellReuseIdentifier:SLHomeDetailView.detailID)
        
        let swipLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
        
        swipLeft.direction = .left
        
        let swipRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
        
        swipRight.direction = .right
        
        tableView.addGestureRecognizer(swipRight)
        
        tableView.addGestureRecognizer(swipLeft)
    }
    
    func swipeGesture(swipe : UISwipeGestureRecognizer) -> () {
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SLHomeDetailView.detailID, for: indexPath) as! SLHomeDetailCell
        
        cell.selectionStyle = .none
        
        cell.labLeft.text = fromMoneyDetailList?[indexPath.row]
        
        cell.labRight.text = toMoneyDetailList?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        closure?()
    }
    
}
