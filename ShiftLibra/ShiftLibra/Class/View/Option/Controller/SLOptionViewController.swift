//
//  SLOptionViewController.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/30.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

enum optionCurrencyType : Int {
    case from = 1001
    case to
}

class SLOptionViewController: UIViewController {
    
    var optionType : optionCurrencyType = .to {
        
        didSet {
            
            switch optionType {
                
            case .from:
                
                tableViewBackgroundColor = top_left_bgColor
                
                themeTextColor = top_left_textColor
                
                subTextColor = top_left_textColor
                
                tableCellViewBackgroundColor = bottom_left_bgColor
                
            case .to:
                
                tableViewBackgroundColor = top_right_bgColor

                themeTextColor = top_right_textColor
                
                subTextColor = bottom_right_textColor
                
                tableCellViewBackgroundColor = bottom_right_bgColor
            }
        }
    }
    
    var tableViewBackgroundColor : UIColor?
    
    var themeTextColor : UIColor?
    
    var subTextColor : UIColor?
    
    var tableCellViewBackgroundColor : UIColor?
    
    let currencyID = "currencyID"
    
    let currencyTypeID = "currencyTypeID"


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        optionType = .from
        
        view.backgroundColor = tableViewBackgroundColor
        
        view.addSubview(headerView)
        
        headerView.backgroundColor = tableViewBackgroundColor
        
        headerView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.view.snp.top).offset(20)
            
            make.left.right.equalTo(self.view)
            
            make.height.equalTo(homeHeaderHight)
        }
        
        headerView.backgroundColor = tableViewBackgroundColor
        
        headerView.addSubview(labInfo)
        
        labInfo.textColor = themeTextColor
        
        labInfo.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(headerView)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(0.5)
        }
        
        headerView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerView).offset(8)
            
            make.right.equalTo(headerView).offset(-48)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(1.5)
        }
        
        searchBar.tintColor = themeTextColor
        
        searchBar.barTintColor = UIColor.clear
        
        searchBar.backgroundColor = UIColor.black
        
        
        
        headerView.addSubview(btnCancel)
        
        btnCancel.snp.makeConstraints { (make) in
            
            make.left.equalTo(searchBar.snp.right).offset(0)
            
            make.right.equalTo(headerView).offset(-8)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(1.5)
        }
        
        btnCancel.setTitleColor(self.themeTextColor, for: .normal)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self.view)
            
            make.top.equalTo(headerView.snp.bottom)
        }
        
        btnCancel.addTarget(self, action: #selector(btnCancelClick), for: .touchUpInside)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.backgroundColor = tableViewBackgroundColor
        
        tableView.register(SLOptionTableViewCell.self, forCellReuseIdentifier: currencyID)
        
        tableView.register(SLOptionTableHeaderView.self, forHeaderFooterViewReuseIdentifier: currencyTypeID)
        
        tableView.rowHeight = homeDetailTableViewCellHight
        
        tableView.separatorInset = .zero
        
        tableView.separatorStyle = .none
        
        tableView.sectionHeaderHeight = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }

    lazy var headerView: UIView = {
        
        let view = UIView()
        
        return view
    }()
    
    lazy var labInfo : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "? -> USD"
        
        lab.font = UIFont.systemFont(ofSize: smallFontSize)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    lazy var searchBar : UISearchBar = {
        
        let view = UISearchBar()
        
        return view
    }()
    
    lazy var btnCancel : UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("取消", for: UIControlState.normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: smallFontSize)
        
        btn.sizeToFit()
        
        return btn
    }()
    
    lazy var tableView : UITableView = {
       
        let view = UITableView(frame: CGRect(), style: .plain)
        
        return view
    }()
}

extension SLOptionViewController {
    
    func btnCancelClick() -> () {
        
        self.dismiss(animated: true) { 
            
        }
    }
}

extension SLOptionViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyID, for: indexPath) as! SLOptionTableViewCell
        
        cell.backgroundColor = tableCellViewBackgroundColor
        
        cell.labCode.textColor = subTextColor
        
        cell.selectionStyle = .none
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: currencyTypeID) as! SLOptionTableHeaderView
        
        headerView.label.textColor = self.themeTextColor
        
        headerView.contentView.backgroundColor = tableViewBackgroundColor
        
        headerView.label.text = "☆\(section)"
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["1","1","1","1","1","1","1","1","1","1"]
    }
}
