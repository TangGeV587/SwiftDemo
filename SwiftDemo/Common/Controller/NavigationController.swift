//
//  NavigationController.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/5/6.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = .white
       
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0), NSAttributedString.Key.font:UIFont.systemFont(ofSize:17)]
    }
    
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"back_arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.didBackButton(sender:)))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    //点击事件
    @objc func didBackButton(sender:UIButton){
        self.popViewController(animated:true)
    }
    
}
