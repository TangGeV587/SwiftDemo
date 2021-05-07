//
//  TransitionController.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/5/6.
//

import UIKit

class TransitionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "转场"
        view.backgroundColor = .white
    }
    
    
    @IBAction func transitionAction(_ sender: UIButton) {
        let detailVC = TransitionDetailController.init()
        detailVC.modalTransitionStyle = .coverVertical
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}
