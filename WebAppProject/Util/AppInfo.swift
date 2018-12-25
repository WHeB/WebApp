//
//  AppInfo.swift
//  WPKit
//  app信息
//  Created by 王鹏 on 2018/7/24.
//  Copyright © 2018年 王海鹏. All rights reserved.
//

import UIKit
import AdSupport

private let kWindow = UIApplication.shared.keyWindow
public struct AppInfo {
    
    /// app名称
    public static var appName: String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /// 版本信息
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// build版本
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    /// bundle id 唯一标识
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /// 名称
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    /// appstore地址
    public static var appStoreURL: URL {
        return URL(string: "http://baidu.com")!
    }
    
    /// 版本 + build
    public static var appVersionAndBuild: String {
        let version = appVersion
        let build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
    /// IDFA
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    /// IDFV
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        return isHasSafeArea ? 44: 20
    }
    
    /// 导航栏高度
    public static var navigationBarHeight: CGFloat {
        return 44
    }
    
    /// tabbar高度
    public static var tabBarHeight: CGFloat {
        return isHasSafeArea ? 83: 49
    }
    
    /// statusBar + navigationBar
    public static var headerBarHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    
    /// 屏幕高
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 屏幕宽
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /// 屏幕高 - 状态栏
    public static var screenHeightWithoutStatusBar: CGFloat {
        return UIScreen.main.bounds.size.height - statusBarHeight
    }
    
    /// 屏幕高 - 状态栏 - 导航栏
    public static var screenHeightWithoutHeaderBar: CGFloat {
        return UIScreen.main.bounds.size.height - headerBarHeight
    }
    
    /// 屏幕高 - tabBarHeight
    public static var screenHeightWithoutTabbar: CGFloat {
        return UIScreen.main.bounds.size.height - tabBarHeight
    }
    
    /// 屏幕高 - 状态栏 - 导航栏 - tabBarHeight
    public static var screenHeightWithoutBar: CGFloat {
        return UIScreen.main.bounds.size.height - headerBarHeight - tabBarHeight
    }
    
    /// Iphone4
    public static var isIphone4: Bool {
        return screenHeight == 480.000000 ? true : false
    }
    
    /// Iphone5
    public static var isIphone5: Bool {
        return screenHeight == 568.000000 ? true : false
    }
    
    /// Iphone6
    public static var isIphone6: Bool {
        return screenHeight == 667.000000 ? true : false
    }
    
    /// Iphone6Plus
    public static var isIphone6P: Bool {
        return screenHeight == 736.000000 ? true : false
    }
    
    /// IphoneX(S)
    public static var isIphoneX: Bool {
        return screenHeight == 812.000000 ? true : false
    }
    
    /// IphoneXR
    public static var isIphoneXR: Bool {
        if screenHeight == 896.000000 && UIScreen.main.scale == 2.0 {
            return true
        }
        return false
    }

    /// IphoneXS Max
    public static var isIphoneXS_Max: Bool {
        if screenHeight == 896.000000 && UIScreen.main.scale == 3.0 {
            return true
        }
        return false
    }
    
    /// 判断是否有齐刘海
    public static var isHasSafeArea: Bool {
        if isIphoneX || isIphoneXR || isIphoneXS_Max {
            return true
        }
        return false
    }
}
