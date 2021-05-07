//
//  TabbarController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class TabbarController: UITabBarController {
    override func viewDidLoad() {
    setValue(TabBar(), forKeyPath: "tabBar")
    addChildController()
    setupTabbarItem()
    }
    
    
    func addChildController()  {
        getChildController(titleStr: "测试", imageName: "icon_main", selectImageName: "icon_main_active", type: TestViewController.self)
        getChildController(titleStr: "首页", imageName: "icon_main", selectImageName: "icon_main_active", type: HomeViewController.self)
        getChildController(titleStr: "学习", imageName: "main_tab_live", selectImageName: "main_tab_live_active", type: StudyViewController.self)
        getChildController(titleStr: "我的", imageName: "main_tab_qbfriends", selectImageName: "main_tab_qbfriends_active", type: MineViewController.self)
    }
    
    func getChildController(titleStr: String,imageName: String,selectImageName: String,type: UIViewController.Type) {
        let homeVC = NavigationController(rootViewController: type.init())
        homeVC.title = titleStr
        homeVC.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: selectImageName)
        addChild(homeVC)
    }
    
    func setupTabbarItem()  {
        tabBar.barTintColor = UIColor.white
        if #available(iOS 13.0, *) {
            UITabBar.appearance().tintColor = UIColor.black
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
//            let appearence = UITabBarAppearance()
//            appearence.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
//            appearence.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
//            tabBarItem.standardAppearance = appearence
        
        }else {
            let appearence = UITabBarAppearance()
            appearence.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
            appearence.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
            tabBarItem.standardAppearance = appearence
        }
//        tabBarItemr
    }
}
