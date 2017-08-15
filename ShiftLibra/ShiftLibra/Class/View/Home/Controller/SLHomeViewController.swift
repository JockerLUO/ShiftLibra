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
    
    fileprivate lazy var homeViewModel : SLHomeViewModel = SLHomeViewModel()
    
    fileprivate var cellHeights = (0..<10).map { _ in C.CellHeight.close }
    
    fileprivate let kCloseCellHeight = homeTableViewCellHight
    
    fileprivate let kOpenCellHeight = homeTableViewCellHight + homeDetailTableViewCellHight * 10
    
    fileprivate var selectIndex : Int = -3
    
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
        
        headerView.closure = { [weak self] in
            
            self?.tableView.delegate?.tableView!((self?.tableView)!, didSelectRowAt: IndexPath(row: self?.selectIndex ?? 0, section: 0))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        headerView.homeViewModel = homeViewModel
        
        tableView.reloadData()
    }
    
    fileprivate lazy var headerView: SLHomeHeaderView = {
        
        let view = SLHomeHeaderView()
        
        return view
    }()
    
    fileprivate lazy var tableView: SLHomeTableView = {
        
        let tableView = SLHomeTableView()
        
        return tableView
    }()
}

extension SLHomeViewController {
    
    @objc fileprivate func headerViewClick(tap : UITapGestureRecognizer) -> () {
        
        if headerView.btnBack.isHidden {
            
            var optionType : SLOptionCurrencyType = .to
            
            let point = tap.location(in: tap.view)
            
            let view = tap.view
            
            let framViewRect = CGRect(x: 0, y: 0, width: (view?.bounds.width)! * 0.5, height: (view?.bounds.height)!)
            
            if framViewRect.contains(point) {
                
                optionType = .from
            }
            
            let showView = SLHomeSettingView(frame: self.view.bounds)
            
            showView.optionType = optionType
            
            showView.homeViewModel = homeViewModel
            
            self.view.addSubview(showView)
            
            showView.closure = { [weak self] in
                
                
                let vc = SLOptionViewController()
                
                vc.optionType = optionType
                
                vc.currency = optionType == .to ? self?.homeViewModel.toCurrency : self?.homeViewModel.fromCurrency
                
                self?.present(vc, animated: true, completion: {
                    
                    showView.removeFromSuperview()
                })
                
                vc.closure = { model in
                    
                    if optionType == .to {
                        
                        if self?.homeViewModel.toCurrency?.code == model.code {
                            
                            self?.shiftHomeModelView()
                            
                        } else {
                            
                            self?.homeViewModel.toCurrency = model
                        }
                        
                    } else {
                     
                        if self?.homeViewModel.fromCurrency?.code == model.code {
                            
                            self?.shiftHomeModelView()
                            
                        } else {
                            
                            self?.homeViewModel.fromCurrency = model
                        }
                    }
                    
                }
                
            }
            
            showView.shiftClosure = { [weak self] in
                
                self?.shiftHomeModelView()
                
                self?.tableView.reloadData()
                
                self?.headerView.update()
            }
            
            showView.settingClosure = { [weak self] in
                
                let customizeView = SLCustomizeView(frame: (self?.view.bounds)!)
                
                var model = optionType == .to ? self?.homeViewModel.toCurrency : self?.homeViewModel.fromCurrency
                
                if model?.code == "CNY" {
                    
                    model = optionType != .to ? self?.homeViewModel.toCurrency : self?.homeViewModel.fromCurrency
                }
                
                customizeView.currency = model
                
                self?.view.addSubview(customizeView)
            }
            
            
        } else {
         
            tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: selectIndex, section: 0))
        }
    }
    
    func shiftHomeModelView() -> () {
        
        let tmp = self.homeViewModel.fromCurrency
        
        self.homeViewModel.fromCurrency = self.homeViewModel.toCurrency
        
        self.homeViewModel.toCurrency = tmp
    }
    
    @objc fileprivate func swipeGesture(swipe : UISwipeGestureRecognizer) -> () {
        
        if headerView.btnBack.isHidden {
            
            switch swipe.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                
                homeViewModel.multiple *= 10
                
            case UISwipeGestureRecognizerDirection.right:
                
                homeViewModel.multiple /= 10
                
            default :
                
                break
            }
            
            NotificationCenter.default.post(name: homeTableViewSwipeGestureNotification, object: swipe.direction)
        }
        
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
        
        cell.labLeft.text = homeViewModel.fromMoneyList[indexPath.row]
        
        cell.labRight.text = homeViewModel.toMoneyList[indexPath.row]
        
        cell.fromMoneyDetailList = homeViewModel.fromMoneyDetailList[indexPath.row]
        
        cell.toMoneyDetailList = homeViewModel.toMoneyDetailList[indexPath.row]
        
        cell.closure = {
            
            tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        }
        
        cell.gestureClosure = {
            
            tableView.reloadData()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row - 1 == selectIndex {
            
            tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: indexPath.row - 1, section: indexPath.section))
            
            selectIndex = -3
            
            return
            
        }
        
        headerView.btnBack.isHidden = !headerView.btnBack.isHidden
        
        tableView.isScrollEnabled = !tableView.isScrollEnabled
        
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
        
        selectIndex = selectIndex == -3 ? indexPath.row : -3
        
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

