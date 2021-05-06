//
//  UIColor+Exension.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/30.
//

import Foundation
 extension UIColor {

    /// 根据十六进制的字符传得出UIColor
       ///
       /// - Parameters:
       ///   - color: 十六进制的字符传的颜色值
       ///   - alpha: 透明读
       /// - Returns:
    public static func hexString(_ color:String,  alpha:CGFloat=1) -> UIColor{
        return self.colorString(color, alpha: alpha)
    }
    /// Hex 十六进制返回颜色
    ///
    /// - Parameters:
    ///   - colorStr: 十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: color
    public static func colorString(_ colorStr:String, alpha:CGFloat=1) -> UIColor{
        var color = UIColor.clear
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = String(cStr[index...])
        }
        if cStr.hasPrefix("0X") {
            let index = cStr.index(after: cStr.startIndex)
            cStr = String(cStr[index...])
        }
        if cStr.count != 6 {
            return UIColor.clear
        }
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let rStr = String(cStr[rRange])
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let gStr = String(cStr[gRange])
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...])
        
        color = UIColor(red: CGFloat(changeToInt(numStr: rStr)) / 255, green: CGFloat(changeToInt(numStr: gStr)) / 255, blue: CGFloat(changeToInt(numStr: bStr)) / 255, alpha: alpha)
        return color
    }
}

fileprivate func changeToInt(numStr:String) -> Int {
       let str = numStr.uppercased()
       var sum = 0
       for i in str.utf8 {
           sum = sum * 16 + Int(i) - 48
           if i >= 65 {
               sum -= 7
           }
       }
       return sum
   }
