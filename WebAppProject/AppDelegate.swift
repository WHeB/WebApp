//
//  AppDelegate.swift
//  WebAppProject
//
//  Created by admin on 2018/12/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.backgroundColor = UIColor.white
//        self.initMeiqia(application) 初始化美恰
        let mainVC = MainViewController.init()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }
    
    /// 初始化美恰
    private func initMeiqia(_ application: UIApplication) {
        MQManager.initWithAppkey("") { (string, error) in
            if error == nil {
                print("美洽 SDK：初始化成功")
            }else {
                print("美洽 SDK：初始化失败")
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

