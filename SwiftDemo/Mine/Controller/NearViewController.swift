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
        view.addSubview(button)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "附近")
      }

    
    //MARK: - lazy
    lazy var button:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("加油", for: .normal)
        button.setTitleColor(UIColor.hexString("#ff0000"), for: .normal)
        button.sizeToFit()
        button.origin = CGPoint(x: 100, y: 100)
        button.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func clickAction(sender:UIButton){
        print("奥利给")
    }
    
}
