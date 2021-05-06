//
//  String+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/6.
//

import Foundation
extension String {
//MARK:- 获取高度计算
    public func height(_ limitWidth: CGSize, _ attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
    let string = self as NSString
    let stringSize = string.boundingRect(with: limitWidth, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    return stringSize.height
}
    
    /// 沙盒路径之cachePath
    func cachePath() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (cachePath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }

    /// 沙盒路径之temp
    func tempPath() -> String {
        let tempPath = NSTemporaryDirectory()
        return (tempPath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    /// 沙盒路径之cachePath
    func documentPath() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (cachePath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }

}
