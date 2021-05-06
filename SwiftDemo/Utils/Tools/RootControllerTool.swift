//
//  RootControllerTool.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/2.
//

import Foundation

struct RootControllerTool {
    
    
    static func rootController() -> UIViewController  {
        
        let currentVersion = SystemInfo.getAppVersion()
        var rootVC:UIViewController?
        let lastVersion = FileHelper.defaultRead("Version")
   
        if lastVersion == nil {
            rootVC = NewfeatureViewController()
        }else {
            switch currentVersion.compare(lastVersion!) {//现在版本大于以前的就展示新特性
            case .orderedDescending:
                rootVC = NewfeatureViewController()
            default:
                rootVC = TabbarController()
            }
        }
        FileHelper.defaultSave("Version", currentVersion)
        return rootVC!

    }
    
    /// 获取登录控制器
    /// - Returns: 登录控制器
    static func loginController() -> UIViewController {
        let loginVC = LoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        return nav
    }
    
    /// 获取当前控制器
    /// - Returns: 当前控制器
    static func getCurrentController() -> UIViewController {
        
        let window = UIApplication.shared.delegate?.window!
        let vc = window?.rootViewController
        
        if (vc?.isKind(of: UITabBarController.self))! {
            return (vc as! UITabBarController).selectedViewController!
        }else if (vc?.isKind(of: UINavigationController.self))!{
          return (vc as! UINavigationController).visibleViewController!
        }else if (vc?.presentationController != nil){
            return  (vc?.presentedViewController)!
        }else {
            return vc!
        }
    }
    
    
}
