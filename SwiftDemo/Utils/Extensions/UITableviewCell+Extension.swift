//
//  UITableviewCell+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//

import UIKit

extension UITableViewCell {
    
   static var reuseIdentify: String {
        NSStringFromClass(self)
    }
    
}

extension UICollectionViewCell {
    
   static var reuseIdentify: String {
        NSStringFromClass(self)
    }
    
}
