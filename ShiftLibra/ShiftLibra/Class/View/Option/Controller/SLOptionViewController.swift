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
                
                textFiledColor = RGB(R: 4, G: 3, B: 7, alpha: 1)
                
            case .to:
                
                tableViewBackgroundColor = RGB(R: 55, G: 71, B: 73, alpha: 1)

                themeTextColor = top_right_textColor
                
                subTextColor = bottom_right_textColor
                
                tableCellViewBackgroundColor = RGB(R: 84, G: 101, B: 102, alpha: 1)
                
                textFiledColor = RGB(R: 24, G: 41, B: 43, alpha: 1)
            }
        }
    }
    
    var tableViewBackgroundColor : UIColor?
    
    var themeTextColor : UIColor?
    
    var subTextColor : UIColor?
    
    var tableCellViewBackgroundColor : UIColor?
    
    let currencyID = "currencyID"
    
    let currencyTypeID = "currencyTypeID"

    var textFiledColor : UIColor?
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        view.addSubview(scrollerView)
        
        scrollerView.backgroundColor = tableViewBackgroundColor
        
        scrollerView.addSubview(tableView)
        
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.backgroundColor = tableViewBackgroundColor
        
        tableView.register(SLOptionTableViewCell.self, forCellReuseIdentifier: currencyID)
        
        tableView.register(SLOptionTableHeaderView.self, forHeaderFooterViewReuseIdentifier: currencyTypeID)
        
        tableView.rowHeight = homeDetailTableViewCellHight
        
        tableView.separatorInset = .zero
        
        tableView.separatorStyle = .none
        
        tableView.sectionHeaderHeight = 25
        
        
        scrollerView.addSubview(headerView)
        
        headerView.backgroundColor = tableViewBackgroundColor
        
        headerView.backgroundColor = tableViewBackgroundColor
        
        headerView.addSubview(labInfo)
        
        labInfo.textColor = themeTextColor
        
        headerView.addSubview(searchBar)
    
        searchBar.tintColor = themeTextColor
        
        for subView in searchBar.subviews {
            
            if subView.isKind(of: UIView.self) {

                subView.subviews[0].removeFromSuperview()
                
                if subView.subviews[0].isKind(of: UITextField.self) {
                    
                    let textFiled : UITextField = subView.subviews[0] as! UITextField
                    
                    textFiled.backgroundColor = textFiledColor
                    
                    textFiled.textColor = themeTextColor
                }
            }
        }

        headerView.addSubview(btnCancel)
        
        btnCancel.setTitleColor(self.themeTextColor, for: .normal)
        
        btnCancel.addTarget(self, action: #selector(btnCancelClick), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        
        scrollerView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self.view)
            
        }
        
        headerView.snp.makeConstraints { (make) in
            
            make.top.equalTo(scrollerView).offset(20)
            
            make.left.equalTo(scrollerView)
            
            make.width.equalTo(SCREENW)
            
            make.height.equalTo(homeHeaderHight)
        }
        
        tableView.snp.makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self.view)
            
            make.top.equalTo(headerView.snp.bottom)
            
            make.height.equalTo(SCREENH - 20 - homeHeaderHight)
            
            make.width.equalTo(SCREENW)
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
    
    lazy var scrollerView : TPKeyboardAvoidingScrollView = {
        
        let scrollerView = TPKeyboardAvoidingScrollView()
        
        return scrollerView
    }()
    
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
        
        let searchBar = UISearchBar()
        
        searchBar.keyboardAppearance = .dark
        
        searchBar.barTintColor = UIColor.clear
        
        return searchBar
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
        
        searchBar.endEditing(true)
        
        self.dismiss(animated: true) { 
            
        }
    }
}

extension SLOptionViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (SLOptionViewModel.shared.currencyList?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
            
            return SLOptionViewModel.shared.queryList?.count ?? 0
        }
        
        let keys = SLOptionViewModel.shared.currencyTyeList

        let count = SLOptionViewModel.shared.currencyList![(keys?[section - 1])!]?.count
        
        return count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyID, for: indexPath) as! SLOptionTableViewCell
        
        cell.backgroundColor = tableCellViewBackgroundColor
        
        cell.labCode.textColor = subTextColor
        
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
        
            cell.currency = SLOptionViewModel.shared.queryList?[indexPath.item]
            
            cell.optionType = self.optionType

            return cell
        }
        
        let keys = SLOptionViewModel.shared.currencyTyeList
        
        let currency = SLOptionViewModel.shared.currencyList![(keys?[indexPath.section - 1])!]?[indexPath.item]
        
        cell.currency = currency
        
        cell.optionType = self.optionType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: currencyTypeID) as! SLOptionTableHeaderView
        
        headerView.label.textColor = self.themeTextColor
        
        headerView.contentView.backgroundColor = tableViewBackgroundColor
        
        if section == 0 {
            
            headerView.label.text = "☆ 热门"
            
            return headerView
        }
        
        headerView.label.text = SLOptionViewModel.shared.currencyTyeList?[section - 1] ?? "☆"
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var arr : [String] = NSMutableArray.init(array: SLOptionViewModel.shared.currencyTyeList!, copyItems: true) as! [String]
    
        arr.insert("☆", at: 0)
        
        return arr
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        var model : SLCurrency
        
        if indexPath.section == 0 {
            
            model = (SLOptionViewModel.shared.queryList?[indexPath.row])!
            
        } else {
            
            let keys = SLOptionViewModel.shared.currencyTyeList
            
            model = (SLOptionViewModel.shared.currencyList![(keys?[indexPath.section - 1])!]?[indexPath.item])!
        }
        
        if self.optionType == .to {
            
            SLHomeViewModel.shared.toCurrency = model
            
        } else {
            
            SLHomeViewModel.shared.fromCurrency = model
        }
        
        self.dismiss(animated: true, completion: {
            
        })
        
        
    }
}
