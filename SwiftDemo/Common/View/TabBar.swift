//
//  TabBar.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/27.
//

import UIKit

class TabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        for button in subviews where button is UIControl {
            var frame = button.frame
            frame.origin.y += 1
            button.frame = frame
        }
    }

}
