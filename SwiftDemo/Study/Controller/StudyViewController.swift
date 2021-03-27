//
//  StudyViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class StudyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

    }
    
    func setupUI() {
        navigationItem.title = "学习"
        view.backgroundColor = UIColor.yellow
    }

}
