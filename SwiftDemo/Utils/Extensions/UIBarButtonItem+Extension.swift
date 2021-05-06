//
//  UIBarButtonItem+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/6.
//

import Foundation


extension UIBarButtonItem {

    static func item(_ title: String,target: Any ,action: Selector ,fontSize:CGFloat? = 14.0,
                     fontColor:String? = "#000000",bold: Bool? = false) -> UIBarButtonItem {
        
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.hexString(fontColor!), for: .normal)
        if bold == true {
            btn.titleLabel?.font = MediumFont(fontSize!)
        }else {
            btn.titleLabel?.font = SystemFont(fontSize!)
        }
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        let containView = UIView()
        containView.frame = btn.bounds
        containView.addSubview(btn)
        return UIBarButtonItem(customView: containView)
    }
    
}
