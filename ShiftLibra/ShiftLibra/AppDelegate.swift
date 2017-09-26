//
//  AppDelegate.swift
//  ShiftLibra
//
//  Created by LUO on 2017/7/18.
//  Copyright © 2017年 JockerLuo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
                
        window = UIWindow()
        
        window?.rootViewController = SLHomeViewController()
        
        window?.makeKeyAndVisible()
     
        getLanguage()
        
        return true
    }
    
    fileprivate func getLanguage() -> () {
        
        let defs = UserDefaults.standard
        
        let languages = defs.object(forKey: "AppleLanguages")
        
        let preferredLanguage = (languages! as? [String])?.first
        
        if preferredLanguage == "zh-Hant-CN" || preferredLanguage == "zh-Hans-CN" || preferredLanguage == "zh-Hans-US" || preferredLanguage == "zh-Hant-US" {
            
            country = "China"
            
        } else {
            
            country = "Foreign"
        }
    }

}



