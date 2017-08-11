//
//  SLHomeViewController.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/23.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import FoldingCell

class SLHomeViewController: UIViewController {

    let cellID = "cellID"
        
    fileprivate struct C {
        struct CellHeight {
            
            static let close: CGFloat = homeTableViewCellHight
            
            static let open: CGFloat = homeTableViewCellHight + homeDetailTableViewCellHight * 10
        }
    }
    
    var cellHeights = (0..<10).map { _ in C.CellHeight.close }
    
    let kCloseCellHeight = homeTableViewCellHight
    
    let kOpenCellHeight = homeTableViewCellHight + homeDetailTableViewCellHight * 10
    
    var selectIndex : Int = -1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(self.view)
            
            make.top.equalTo(self.view.snp.top).offset(20)
            
            make.height.equalTo(homeHeaderHight)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerViewClick(tap:)))

        headerView.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalTo(headerView.snp.bottom)
            
            make.left.bottom.right.equalTo(self.view)
            
        }
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorInset = .zero
        
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = kCloseCellHeight
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(SLHomeCell.self, forCellReuseIdentifier: cellID)
        
        let swipLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
        
        swipLeft.direction = .left
        
        let swipRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(swipe:)))
        
        swipRight.direction = .right
        
        tableView.addGestureRecognizer(swipRight)
        
        tableView.addGestureRecognizer(swipLeft)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.headerView.labLeft.text = SLHomeViewModel.shared.fromCurrency?.code ?? "CNY"
        
        self.headerView.labRight.text = SLHomeViewModel.shared.toCurrency?.code ?? "USD"

        tableView.reloadData()
    }
    
    lazy var headerView: SLHomeHeaderView = {
        
        let view = SLHomeHeaderView()
        
        return view
    }()
    
    lazy var tableView: SLHomeTableView = {
        
        let tableView = SLHomeTableView()
        
        return tableView
    }()
}

extension SLHomeViewController {
    
    func headerViewClick(tap : UITapGestureRecognizer) -> () {
        
        var optionType : SLOptionCurrencyType = .to
        
        let point = tap.location(in: tap.view)
        
        let view = tap.view
        
        let framViewRect = CGRect(x: 0, y: 0, width: (view?.bounds.width)! * 0.5, height: (view?.bounds.height)!)
        
        if framViewRect.contains(point) {
            
            optionType = .from
        }
    
        SLHomeSettingView.show(superController: self, optionType: optionType)
    }
    
    func swipeGesture(swipe : UISwipeGestureRecognizer) -> () {
        
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.left:
            
            SLHomeViewModel.shared.multiple *= 10
            
        case UISwipeGestureRecognizerDirection.right:
            
            SLHomeViewModel.shared.multiple /= 10
            
        default :
            break
        }
        
        tableView.reloadData()
    }
}

extension SLHomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SLHomeCell
        
        cell.selectionStyle = .none
        
        cell.labLeft.text = "\(String(Double(indexPath.row + 1) * SLHomeViewModel.shared.toMoney))\(SLHomeViewModel.shared.fromMoneyDigits ?? "")"
        
        cell.labRight.text = "\(String(Double(indexPath.row + 1) * SLHomeViewModel.shared.fromMoney))\(SLHomeViewModel.shared.fromMoneyDigits ?? "")"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.isScrollEnabled = !tableView.isScrollEnabled
        
        headerView.btnBack.isHidden = !headerView.btnBack.isHidden
        
        
        
//        tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: indexPath.row + 1, section: indexPath.section))
        
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath as IndexPath) else {
            
            return
        }
        
        var duration = 0.0
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cellHeights[indexPath.row] = kOpenCellHeight
            
            cell.setSelected(true, animated: true)
            duration = 0.25
            
        } else {
            
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.setSelected(false, animated: true)
            duration = 0.25
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { 
            _ in
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        }) { (_) in
            
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if case let cell as FoldingCell = cell {
            if cellHeights[indexPath.row] == C.CellHeight.close {
                cell.setSelected(false, animated: false)
            } else {
                cell.setSelected(true, animated: false)
            }
        }
    }
}

