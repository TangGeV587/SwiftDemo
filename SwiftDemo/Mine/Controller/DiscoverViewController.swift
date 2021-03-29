//
//  DiscoverViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/29.
//

import UIKit
import XLPagerTabStrip
class DiscoverViewController: ButtonBarPagerTabStripViewController,IndicatorInfoProvider {
    let kChannels = ["推荐","旅行","娱乐","才艺","美妆","白富美","美食","萌宠"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "发现")
      
      }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcArray:[UIViewController] = []
        for channel in kChannels {
            let vc = WaterFlowController()
            vc.channelStr = channel
            vcArray.append(vc)
        }
        return vcArray
    }
}
