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
    
    var superController : UIViewController?
    
    class func show(superController : UIViewController) -> () {
        
        let view = SLHomeSettingView(frame: superController.view.bounds)
        
        view.superController = superController
        
        superController.view.addSubview(view)
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
        
        settingView.addSubview(btnSetting)
        
        settingView.addSubview(btnShift)
        
        settingView.addSubview(btnOther)
        
        addSubview(btnCancel)
        
        anim()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
    }
    
    lazy var bgView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH))
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return view
    }()
    
    lazy var settingView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: SCREENH, width: SCREENW, height: homeHeaderHight + homeTableViewCellHight * 3))
        
        view.backgroundColor = top_left_bgColor
        
        return view
    }()
    
    lazy var infoView : UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: homeHeaderHight))
        
        let now = NSString.init(data: Data(), encoding: 5)
        
        let name = "已更新:今天"
        
        let str = "1 USD -> 6.7361 CNY\n\(name)"
        
        let range : NSRange = (str as NSString).range(of: name)
        
        let attr = NSMutableAttributedString(string: str)
        
        attr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: smallFontSize), NSForegroundColorAttributeName : mid_right_bgColor], range: range)
        
        let lab = UILabel()
        
        lab.numberOfLines = 0
        
        lab.font = UIFont.systemFont(ofSize: normalFontSize)
        
        lab.textColor = bottom_right_bgColor
        
        lab.attributedText = attr
        
        lab.textAlignment = .center
        
        lab.sizeToFit()
        
        view.addSubview(lab)
        
        lab.center = view.center
        
        return view
    }()
    
    
    
    lazy var btnSetting: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 0, y: homeHeaderHight, width: SCREENW, height: homeTableViewCellHight))
        
        btn.setTitleColor(bottom_right_textColor, for: UIControlState.normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: settingFontSize)
        
        btn.titleLabel?.textAlignment = .left
        
        btn.setTitle(" ✏️  设定自定义汇率...", for: UIControlState.normal)
        
        return btn
    }()
    
    lazy var btnShift: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 0, y: homeHeaderHight + homeTableViewCellHight, width: SCREENW, height: homeTableViewCellHight))
        
        btn.setTitleColor(bottom_right_textColor, for: UIControlState.normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: settingFontSize)
        
        btn.titleLabel?.textAlignment = .left
        
        btn.setTitle(" 🔄  切换", for: UIControlState.normal)
        
        return btn
    }()

    lazy var btnOther: UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 0, y: homeHeaderHight + homeTableViewCellHight * 2, width: SCREENW, height: homeTableViewCellHight))
        
        btn.setTitleColor(bottom_right_textColor, for: UIControlState.normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: settingFontSize)
        
        btn.titleLabel?.textAlignment = .left

        btn.setTitle(" ⌥  选择其他...", for: UIControlState.normal)
        
        return btn
    }()
    
    lazy var btnCancel : UIButton = {
        
        let btn = UIButton(frame: CGRect(x: 0, y: SCREENH, width: SCREENW, height: homeTableViewCellHight))
        
        btn.setTitle("取消", for: UIControlState.normal)
        
        btn.setTitleColor(bottom_left_textColor, for: UIControlState.normal)
        
        btn.backgroundColor = UIColor.darkText
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: settingFontSize)
        
        return btn
    }()
}

extension SLHomeSettingView {
    
    func anim() -> () {
        
        let settingAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        settingAnimation?.toValue = CGPoint(x: settingView.center.x, y: settingView.center.y - settingView.bounds.height - btnCancel.bounds.height)
        
        settingAnimation?.beginTime = CACurrentMediaTime()
        
        settingAnimation?.springBounciness = 10
        
        settingView.pop_add(settingAnimation, forKey: nil)
        
        
        let cancelAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        cancelAnimation?.toValue = CGPoint(x: btnCancel.center.x, y: btnCancel.center.y - btnCancel.bounds.height)
        
        cancelAnimation?.beginTime = CACurrentMediaTime()
        
        cancelAnimation?.springBounciness = 10
        
        btnCancel.pop_add(cancelAnimation, forKey: nil)
        
    }
}
