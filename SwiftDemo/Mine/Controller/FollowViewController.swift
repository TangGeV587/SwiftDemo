//
//  FollowViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/29.
//

import UIKit
import XLPagerTabStrip

class FollowViewController: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "关注")
      }

}
