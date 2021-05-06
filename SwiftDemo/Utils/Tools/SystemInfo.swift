//
//  SystemInfo.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//

import Foundation

struct SystemInfo {
    //获取版本号
    static func getAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    //获取构建号
    static func getBuildCode() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    /** 打电话 */
    static func callToNum(numString:String){
        guard let url  = URL(string:"tel:\(numString)") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:],completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
