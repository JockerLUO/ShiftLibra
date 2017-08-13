//
//  SLHomeSettingView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/29.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import pop

class SLHomeSettingView: UIView {
    
    var closure : (()->())?
    
    var shiftClosure : (()->())?
    
    var settingClosure : (()->())?
    
    var optionType : SLOptionCurrencyType?
    
    var homeViewModel : SLHomeViewModel? {
        
        didSet {
            
            let fromCurrency = homeViewModel?.fromCurrency
            
            let toCurrency = homeViewModel?.toCurrency
            
            let exchange = homeViewModel?.exchange ?? 1.0
            
            let name = "已更新:\(toCurrency?.updatetime ?? "刚刚")"
            
            let str = "1 \(fromCurrency?.code ?? "USD") → \(exchange) \(toCurrency?.code ?? "CNY")\n\(name)"
            
            let range : NSRange = (str as NSString).range(of: name)
            
            let attr = NSMutableAttributedString(string: str)
            
            attr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: smallFontSize), NSForegroundColorAttributeName : mid_right_bgColor], range: range)
            
            labInfo.attributedText = attr
            
            labInfo.sizeToFit()
            
            labInfo.center = infoView.center
        }
    }
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> () {
        
        addSubview(bgView)
        
        addSubview(settingView)
        
        settingView.addSubview(infoView)
        
        infoView.addSubview(labInfo)
        
        settingView.addSubview(btnSetting)
        
        settingView.addSubview(btnShift)
        
        settingView.addSubview(btnOther)
        
        addSubview(btnCancel)
        
        anim()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
    }
    
    fileprivate lazy var bgView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH))
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return view
    }()
    
    fileprivate lazy var settingView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: SCREENH, width: SCREENW, height: homeHeaderHight + homeTableViewCellHight * 3))
        
        view.backgroundColor = top_left_bgColor
        
        return view
    }()
    
    fileprivate lazy var infoView : UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: homeHeaderHight))
        
        let now = NSString.init(data: Data(), encoding: 5)
        
        return view
    }()
    
    fileprivate lazy var labInfo: UILabel = {
        
        let lab = UILabel()
        
        lab.numberOfLines = 0
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.textColor = bottom_right_bgColor
        
        lab.textAlignment = .center
        
        lab.sizeToFit()
        
        return lab
    }()
    
    fileprivate lazy var btnSetting: UIButton = UIButton(frame: CGRect(x: 0, y: homeHeaderHight, width: SCREENW, height: homeTableViewCellHight), title: " ✏️  设定自定义汇率...", titleColor: bottom_right_textColor, font: settingFontSize, target: self, action: #selector(btnSettingClick))
    
    fileprivate lazy var btnShift: UIButton = UIButton(frame: CGRect(x: 0, y: homeHeaderHight + homeTableViewCellHight, width: SCREENW, height: homeTableViewCellHight), title: " 🔄  切换", titleColor: bottom_right_textColor, font: settingFontSize, target: self, action: #selector(btnShiftClick))
    
    fileprivate lazy var btnOther: UIButton = UIButton(frame: CGRect(x: 0, y: homeHeaderHight + homeTableViewCellHight * 2, width: SCREENW, height: homeTableViewCellHight), title: " ⌥  选择其他...", titleColor: bottom_right_textColor, font: settingFontSize, target: self, action: #selector(btnOtherClick))
    
    fileprivate lazy var btnCancel: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 0, y: SCREENH, width: SCREENW, height: homeTableViewCellHight))
        
        btn.setTitle("取消", for: UIControlState.normal)
        
        btn.setTitleColor(bottom_left_textColor, for: UIControlState.normal)
        
        btn.backgroundColor = UIColor.darkText
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: settingFontSize)
        
        btn.addTarget(self, action: #selector(btnCancelClick), for: .touchUpInside)

        return btn
    }()
}

extension SLHomeSettingView {
    
    @objc fileprivate func btnSettingClick() -> () {
        
        settingClosure?()
        
        self.removeFromSuperview()
        
    }
    
    @objc fileprivate func btnShiftClick() -> () {
        
        shiftClosure?()
        
        self.removeFromSuperview()
    }
    
    @objc fileprivate func btnOtherClick() -> () {
        
        let vc = SLOptionViewController()
        
        vc.optionType = self.optionType!
        
        closure?()
    }
    
    @objc fileprivate func btnCancelClick() -> () {
        
        self.removeFromSuperview()
    }
    
}

extension SLHomeSettingView {
    
    fileprivate func anim() -> () {
        
        let settingAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        settingAnimation?.toValue = CGPoint(x: settingView.center.x, y: settingView.center.y - settingView.bounds.height - btnCancel.bounds.height)
        
        settingAnimation?.beginTime = CACurrentMediaTime()
        
        settingAnimation?.springBounciness = 0
        
        settingView.pop_add(settingAnimation, forKey: nil)
        
        let cancelAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        cancelAnimation?.toValue = CGPoint(x: btnCancel.center.x, y: btnCancel.center.y - btnCancel.bounds.height)
        
        cancelAnimation?.beginTime = CACurrentMediaTime()
        
        cancelAnimation?.springBounciness = 0
        
        btnCancel.pop_add(cancelAnimation, forKey: nil)
        
    }
}
