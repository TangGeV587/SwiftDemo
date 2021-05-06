//
//  MineViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit
import XLPagerTabStrip

class MineViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        initialUI()
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.systemPink
        navigationItem.title = "我的"
        containerView.bounces = false
//        DispatchQueue.main.async {
//            self.moveToViewController(at: 1, animated: false)
//        }
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = UIColor.white
            
//            if animated {
//                UIView.animate(withDuration: 0.1, animations: { () -> Void in
//                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//                })
//            }
//            else {
//                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//            }
        }
    }
    
    func initialUI(){
        //整个容器的背景色
        settings.style.buttonBarBackgroundColor = .lightGray
        //间隔宽度
        settings.style.buttonBarMinimumLineSpacing = 30
        settings.style.buttonBarLeftContentInset = 115;
        settings.style.buttonBarRightContentInset = 115

        //指示器 设置
        settings.style.selectedBarBackgroundColor = .blue
        settings.style.selectedBarHeight = 3

          //item 颜色
        settings.style.buttonBarItemBackgroundColor = .systemPink
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16)
        settings.style.buttonBarItemLeftRightMargin = 5
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
    }
    
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
      return [DiscoverViewController(), FollowViewController(),NearViewController()]
    }
    


}
