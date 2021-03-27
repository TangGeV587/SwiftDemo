//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        navigationItem.title = "首页"
        view.backgroundColor = UIColor.red
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
