//
//  FileHelper.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/2.
//

import Foundation

struct FileHelper {
    
    /// 读取沙盒文件
    /// - Parameter keyName: key名称
    /// - Returns: 返回数据
    static func defaultRead(_ keyName:String) -> String? {
        return  UserDefaults.standard.object(forKey: keyName) as? String
    }
    
    static func defaultSave(_ keyName:String ,_ value:String) {
        
        UserDefaults.standard.setValue(value, forKey: keyName)
        UserDefaults.standard.synchronize()
    }
    
    
}
