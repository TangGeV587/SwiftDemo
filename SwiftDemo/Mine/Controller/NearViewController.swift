//
//  NearViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/29.
//

import UIKit
import XLPagerTabStrip
class NearViewController: UIViewController,IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附近")
      }

}
