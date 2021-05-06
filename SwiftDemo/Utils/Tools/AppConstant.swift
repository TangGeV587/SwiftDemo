//
//  AppConstant.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//
//  App 的一些常量，比如全局的枚举值、常用数值、高频工具函数等
//

import Foundation

// ============================================================================
// MARK:- Function
// ============================================================================

/// 判断是否是`iPhoneX`系列，此系列有`safeArea`的概念
/// - Returns: true代表是`iPhoneX`系列
public func iPhoneX() -> Bool {
    // 利用safeAreaInsets.bottom > 0 来判断是否是iPhoneX系列
    guard let w = UIApplication.shared.delegate?.window else {
        return false
    }
    
    guard #available(iOS 11.0, *) else {
        return false
    }
    
    return w!.safeAreaInsets.bottom > 0.0
}


// ============================================================================
// MARK:- Constants
// ============================================================================

/// -> 手机屏幕的宽度
public let kScreenWidth = UIScreen.main.bounds.width
/// -> 手机屏幕的高度
public let kScreenHeight = UIScreen.main.bounds.height

/// `iPhoneX`系列顶部的安全边距
var kNavigationVar: CGFloat = 44.0

/// `iPhoneX`系列底部的安全边距
var kiPhoneXSafeBottom: CGFloat {
     iPhoneX() ? 34.0 : 0.0
}

/// App状态栏的高度
var kStatusBarHeight: CGFloat {
     iPhoneX() ? 40.0 : 20
}

/// App导航栏高度，包含状态栏(20/44)
var kNavigatioHeight: CGFloat {
     iPhoneX() ? 88.0 : 64.0
}

/// App`TabBar`的高度
var kTabBarHeight: CGFloat {
     iPhoneX() ? 83.0 : 49.0
}
