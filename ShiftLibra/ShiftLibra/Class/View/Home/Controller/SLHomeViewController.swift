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
    
//    let headerID = "headerID"

    
//    override func loadView() {
//        view = tableView
//    }
    
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = SCREENH / 11
            static let open: CGFloat = SCREENH * 10 / 11
        }
    }
    
    var cellHeights = (0..<10).map { _ in C.CellHeight.close }
    
    let kCloseCellHeight = CGFloat(SCREENH / 11)
    
    let kOpenCellHeight = CGFloat(SCREENH * 10 / 11)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(self.view)
            
            make.top.equalTo(self.view.snp.top).offset(20)
            
            make.height.equalTo(SCREENH / 11)
            
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalTo(headerView.snp.bottom)
            
            make.left.bottom.right.equalTo(self.view)
            
        }
        
        
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.separatorInset = .zero
        
        tableView.estimatedRowHeight = kCloseCellHeight
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(SLHomeCell.self, forCellReuseIdentifier: cellID)
        
//        tableView.register(SLHomeHeaderView.self, forHeaderFooterViewReuseIdentifier: headerID)
    }
    
    lazy var headerView: SLHomeHeaderView = {
        
        let view = SLHomeHeaderView()
        
        return view
    }()
    
    
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.backgroundColor = homeTable_bgcolor
        
        return tableView
    }()
}

extension SLHomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath as IndexPath) else {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            
            cell.setSelected(true, animated: true)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.setSelected(false, animated: true)
            duration = 1.1
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

//extension SLHomeViewController {
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:headerID )
//        
//        return headerView
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return SCREENH / 11
//    }
//}
