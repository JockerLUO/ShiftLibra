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
     
        return true
    }

}

