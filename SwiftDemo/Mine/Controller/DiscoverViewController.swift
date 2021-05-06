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
        
        //指示器 设置
        settings.style.selectedBarHeight = 0

          //item 颜色
        settings.style.buttonBarItemBackgroundColor = .lightText
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14)
//        settings.style.buttonBarItemLeftRightMargin = 5
        settings.style.buttonBarItemTitleColor = .black
        
        
        super.viewDidLoad()
        view.backgroundColor = .yellow
        containerView.bounces = false
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
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
