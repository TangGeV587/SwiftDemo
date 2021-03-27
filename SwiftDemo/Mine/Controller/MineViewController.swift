//
//  MineViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.systemPink
        navigationItem.title = "我的"
    }
    

}
