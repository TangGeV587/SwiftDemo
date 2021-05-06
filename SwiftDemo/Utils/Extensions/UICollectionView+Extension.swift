//
//  UICollectionView+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/6.
//

import Foundation

extension UICollectionView {
    public func registerNib(_ nibName: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    public func registerClass(_ className: String) {
        register(NSClassFromString(className).self, forCellWithReuseIdentifier: className)
    }
    
    public func registerNib(_ nibName: String, identifier: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
