//
//  SLOptionViewController.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/30.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding


enum SLOptionCurrencyType : Int {
    case from = 1001
    case to
}

class SLOptionViewController: UIViewController {
    
    var optionType : SLOptionCurrencyType = .to {
        
        didSet {
            
            switch optionType {
                
            case .from:
                
                tableViewBackgroundColor = top_left_bgColor
                
                themeTextColor = top_left_textColor
                
                subTextColor = top_left_textColor
                
                tableCellViewBackgroundColor = bottom_left_bgColor
                
            case .to:
                
                tableViewBackgroundColor = RGB(R: 55, G: 71, B: 73, alpha: 1)

                themeTextColor = top_right_textColor
                
                subTextColor = bottom_right_textColor
                
                tableCellViewBackgroundColor = RGB(R: 84, G: 101, B: 102, alpha: 1)
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
                
        view.backgroundColor = tableViewBackgroundColor
        
        
        view.addSubview(tableView)
        
        
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
        
        
        
        
        
        tableView.tableHeaderView = headerView
        
        headerView.backgroundColor = tableViewBackgroundColor
        
//        headerView.snp.makeConstraints { (make) in
//            
//            make.top.equalTo(tableView.snp.top).offset(0)
//            
//            make.left.right.equalTo(tableView)
//            
//            make.height.equalTo(homeHeaderHight)
//        }
        
        headerView.backgroundColor = tableViewBackgroundColor
        
        headerView.addSubview(labInfo)
        
        labInfo.textColor = themeTextColor
        
       
        
        headerView.addSubview(searchBar)
        
        
        searchBar.tintColor = themeTextColor
        
        searchBar.barTintColor = UIColor.clear
        
        searchBar.backgroundColor = UIColor.black

        
        headerView.addSubview(btnCancel)
        
        
        
        btnCancel.setTitleColor(self.themeTextColor, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self.view)
            
            make.top.equalTo(20)
        }
        
        headerView.snp.makeConstraints { (make) in
            
            make.top.left.equalTo(tableView).offset(0)
            
            make.width.equalTo(SCREENW)
            
            make.height.equalTo(homeHeaderHight)
        }
        
        labInfo.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(headerView)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(0.5)
        }
        
        searchBar.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerView).offset(8)
            
            make.right.equalTo(headerView).offset(-48)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(1.5)
        }
        
        btnCancel.snp.makeConstraints { (make) in
            
            make.left.equalTo(searchBar.snp.right).offset(0)
            
            make.right.equalTo(headerView).offset(-8)
            
            make.centerY.equalTo(headerView.snp.centerY).multipliedBy(1.5)
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        
    }
    
    

    lazy var headerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width:SCREENW, height: homeHeaderHight))
        
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
    
    lazy var tableView : TPKeyboardAvoidingTableView = {
       
        let view = TPKeyboardAvoidingTableView(frame: CGRect(), style: .plain)
        
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
        
        return (SLOptionViewModel.shared.currencyList?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let keys = SLOptionViewModel.shared.currencyTyeList

        let count = SLOptionViewModel.shared.currencyList![(keys?[section])!]?.count
        
        return count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyID, for: indexPath) as! SLOptionTableViewCell
        
        cell.backgroundColor = tableCellViewBackgroundColor
        
        cell.labCode.textColor = subTextColor
        
        cell.selectionStyle = .none
        
        let keys = SLOptionViewModel.shared.currencyTyeList

        let currency = SLOptionViewModel.shared.currencyList![(keys?[indexPath.section])!]?[indexPath.item]
        
        cell.currency = currency
        
        cell.optionType = self.optionType
        
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
        
        return SLOptionViewModel.shared.currencyTyeList
    }
}
