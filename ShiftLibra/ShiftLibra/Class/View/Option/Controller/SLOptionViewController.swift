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
    
    var currency : SLCurrency? {
        
        didSet {
            
            labInfo.text = "? → \(currency?.code ?? "")"
        }
        
    }
    
    lazy var optionViewModel : SLOptionViewModel = SLOptionViewModel()
    
    var searchList : [SLCurrency]?
    
    var closure : ((SLCurrency)->())?
    
    var optionType : SLOptionCurrencyType = .to {
        
        didSet {
            
            switch optionType {
                
            case .from:
                
                tableViewBackgroundColor = top_left_bgColor
                
                themeTextColor = top_left_textColor
                
                tableCellViewBackgroundColor = bottom_left_bgColor
                
                textFiledColor = RGB(R: 4, G: 3, B: 7, alpha: 1)
                
            case .to:
                
                tableViewBackgroundColor = RGB(R: 55, G: 71, B: 73, alpha: 1)
                
                themeTextColor = top_right_textColor
                
                tableCellViewBackgroundColor = RGB(R: 84, G: 101, B: 102, alpha: 1)
                
                textFiledColor = RGB(R: 24, G: 41, B: 43, alpha: 1)
            }
        }
    }
    
    fileprivate var tableViewBackgroundColor : UIColor?
    
    fileprivate var themeTextColor : UIColor?
    
    fileprivate var tableCellViewBackgroundColor : UIColor?
    
    fileprivate let currencyID = "currencyID"
    
    fileprivate let currencyTypeID = "currencyTypeID"
    
    fileprivate var textFiled : UITextField?
    
    fileprivate var textFiledColor : UIColor?
    
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
        
        tableView.sectionIndexBackgroundColor = tableViewBackgroundColor
        
        tableView.sectionIndexColor = themeTextColor
        
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
                    
                    self.textFiled = textFiled
                    
                    textFiled.backgroundColor = textFiledColor
                    
                    textFiled.textColor = themeTextColor
                }
            }
        }
        
        searchBar.delegate = self
        
        headerView.addSubview(btnCancel)
        
        btnCancel.setTitleColor(self.themeTextColor, for: .normal)
        
        btnCancel.addTarget(self, action: #selector(btnCancelClick), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
        
    }
    
    /*
     NSConcreteNotification 0x1744436f0 {name = UIKeyboardWillChangeFrameNotification; userInfo = {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = 0;
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 254}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 460}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 441}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 314}, {320, 254}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }}
     */
    
    override func viewDidAppear(_ animated: Bool) {
        
        textFiled?.becomeFirstResponder()
        
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
    
    
    fileprivate lazy var scrollerView : TPKeyboardAvoidingScrollView = {
        
        let scrollerView = TPKeyboardAvoidingScrollView()
        
        return scrollerView
    }()
    
    fileprivate lazy var headerView: UIView = {
        
        let view = UIView()
        
        return view
    }()
    
    fileprivate lazy var labInfo : UILabel = {
        
        let lab = UILabel()
        
        lab.text = "? → USD"
        
        lab.font = UIFont.systemFont(ofSize: smallFontSize)
        
        lab.sizeToFit()
        
        return lab
    }()
    
    fileprivate lazy var searchBar : UISearchBar = {
        
        let searchBar = UISearchBar()
        
        searchBar.keyboardAppearance = .dark
        
        searchBar.barTintColor = UIColor.clear
        
        return searchBar
    }()
    
    fileprivate lazy var btnCancel : UIButton = {
        
        let btn = UIButton()
        
        btn.setTitle("取消", for: UIControlState.normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: smallFontSize)
        
        btn.sizeToFit()
        
        return btn
    }()
    
    fileprivate lazy var tableView : TPKeyboardAvoidingTableView = {
        
        let view = TPKeyboardAvoidingTableView(frame: CGRect(), style: .plain)
        
        return view
    }()
    
    
}

extension SLOptionViewController {
    
    @objc fileprivate func btnCancelClick() -> () {
        
        searchBar.endEditing(true)
        
        self.isEditing = false
        
        self.dismiss(animated: true) {
            
        }
    }
}

extension SLOptionViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchList != nil {
            
            return 1
        }
        
        
        return (optionViewModel.currencyList?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchList != nil {
            
            return (searchList?.count)!
        }
        
        let keys = optionViewModel.currencyTyeList
        
        let count = optionViewModel.currencyList![(keys?[section])!]?.count
        
        return count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyID, for: indexPath) as! SLOptionTableViewCell
        
        cell.backgroundColor = tableCellViewBackgroundColor
        
        cell.selectionStyle = .none
        
        cell.optionType = self.optionType
        
        if searchList != nil {
            
            cell.currency = searchList?[indexPath.row]
            
            return cell
        }
        
        let keys = optionViewModel.currencyTyeList
        
        let currency = optionViewModel.currencyList![(keys?[indexPath.section])!]?[indexPath.row]
        
        cell.currency = currency
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: currencyTypeID) as! SLOptionTableHeaderView
        
        headerView.label.textColor = self.themeTextColor
        
        headerView.contentView.backgroundColor = tableViewBackgroundColor
        
        var str = optionViewModel.currencyTyeList?[section] ?? ""
        
        if str == "query" {
            
            str = "☆热门"
        }
        
        if str == "customize" {
            
            str = "自定义汇率"
        }
        
        headerView.label.text = str
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var arr : [String] = NSMutableArray.init(array: optionViewModel.currencyTyeList!, copyItems: true) as! [String]
        
        if arr[0] == "customize" {
            
            arr.remove(at: 0)
            
            arr.remove(at: 0)
            
            arr.insert("☆", at: 0)
            
            arr.insert("★", at: 0)
            
        } else {
            
            arr.remove(at: 0)
            
            arr.insert("☆", at: 0)
        }
        
        return arr
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var model : SLCurrency
        
        if searchList != nil {
            
            model = (searchList?[indexPath.row])!
            
            
        } else {
            
            let keys = optionViewModel.currencyTyeList
            
            model = (optionViewModel.currencyList![(keys?[indexPath.section])!]?[indexPath.item])!
            
        }
        
        if model.query == nil {
            
            let alertVC = UIAlertController(title: "提示", message: "查询不到该货币兑换相关信息", preferredStyle: .actionSheet)
            
            let confirm = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                
                return
            })
            
            alertVC.addAction(confirm)
            
            self.present(alertVC, animated: true, completion: nil)
            
            return
        }
        
        closure?(model)
        
        self.isEditing = false
        
        self.dismiss(animated: true, completion: {
            
        })
    }
}

extension SLOptionViewController : UISearchBarDelegate,UITextFieldDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let str = searchBar.text ?? ""
        
        searchList = SLSQLManager.shared.selectSQL(sql: "SELECT * FROM T_Currency WHERE name LIKE '%\(str)%' OR  code LIKE '%\(str)%' ORDER BY code ASC AND query != 'customize';")
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchList != nil {
            
            searchList = nil
            
            tableView.reloadData()
        }
        
    }
    
    
}
