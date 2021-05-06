//
//  UITableView+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/6.
//

import Foundation

extension UITableView {
    public func registerNib(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: nibName)
    }
    
    public func registerClass(_ className: String) {
        register(NSClassFromString(className), forCellReuseIdentifier: className)
    }
}
