//
//  SLCustomizeView.swift
//  ShiftLibra
//
//  Created by LUO on 2017/8/13.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit
import pop

class SLCustomizeView: UIView {
    
    var closure : (()->())?
    
    var currency : SLCurrency? {
        
        didSet {
            
            labInfo.text = "\(customExchange):\(currency?.code ?? "") → CNY"
            
            labFrom.text = currency?.code ?? ""
            
            textTo.text = String(format: "%.4f", currency?.exchange ?? 1.0)
        }
        
    }
    
    @IBOutlet weak var labInfo: UILabel!
    
    @IBOutlet weak var labFrom: UILabel!
    
    @IBOutlet weak var labTo: UILabel!
    
    @IBOutlet weak var textFrom: UITextField!
    
    @IBOutlet weak var textTo: UITextField!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    @IBAction func btnCancelClick(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func btnFinishClick(_ sender: Any) {
        
        guard let toVulue = (textTo.text as NSString?)?.doubleValue else {
            
            return
        }
        
        guard let fromVulue = (textFrom.text as NSString?)?.doubleValue else {
            
            return
        }
        
        
        let customizeList = SLOptionViewModel().customizeList
        
        var sql : String = "INSERT INTO T_Currency (name,code,query,exchange,name_English) VALUES('\(customCurrency)\(currency?.name! ?? "")','\(currency?.code! ?? "")★','customize',\(toVulue / fromVulue),'\(currency?.name_English ?? "")★')"
        
        if (customizeList?.count)! > 0 {
            
            for customizeCurrency in customizeList! {
                
                if customizeCurrency.code! == ((currency?.code)! + "★") {
                    
                    sql = "UPDATE T_Currency set exchange=\(toVulue / fromVulue) WHERE code='\(customizeCurrency)';"
                    
                }
            }
        }
            
        SLSQLManager.shared.insertToSQL(sql: sql)
        
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    private func setupUI() -> () {
        
        addSubview(bgView)
        
        addSubview(settingView)
        
        textTo.becomeFirstResponder()
        
        btnCancel.setTitle(btnCancelText, for: .normal)
        
        btnFinish.setTitle(btnFinishText, for: .normal)
        
        anim()
    }
    
    fileprivate lazy var bgView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH))
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        return view
    }()
    
    fileprivate lazy var settingView: UIView = {
        
        let nib = UINib(nibName: "SLCustomizeView", bundle: nil)
        
        let nibView = nib.instantiate(withOwner: self, options: [:]).first as! UIView
        
        nibView.frame = CGRect(x: 0, y: -(homeHeaderHight + homeTableViewCellHight * 3), width: SCREENW, height: homeHeaderHight + homeTableViewCellHight * 3)
        
        return nibView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first?.view == bgView {
            
            removeFromSuperview()
        }
    }
}

extension SLCustomizeView {
    
    @objc fileprivate func btnOtherClick() -> () {
        
        closure?()
    }
    
    @objc fileprivate func btnCancelClick() -> () {
        
        self.removeFromSuperview()
    }
}

extension SLCustomizeView : POPAnimationDelegate{
    
    fileprivate func anim() -> () {
        
        let settingAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        
        settingAnimation?.toValue = CGPoint(x: settingView.center.x, y: homeHeaderHight + settingView.bounds.height * 0.5)
        
        settingAnimation?.beginTime = CACurrentMediaTime()
        
        settingAnimation?.springBounciness = 0
        
        settingView.pop_add(settingAnimation, forKey: nil)
        
        settingAnimation?.delegate = self
    }
    
    func pop_animationDidStop(_ anim: POPAnimation!, finished: Bool) {
        
        
    }
}
