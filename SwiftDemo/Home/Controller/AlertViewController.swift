//
//  AlertViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/4/7.
//

import UIKit

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "弹框测试"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        EZAlertController.alert("hello")
//        EZAlertController.alert("大家好", message: "helllo")
//        EZAlertController.alert("大家好", message: "加油", buttons: ["确定","取消"],buttonsPreferredStyle: [.default,.destructive]) { (action, index) in
//            if index == 0 {
//                print("点击了 取消")
//            }else {
//                print("点击了 确定")
//            }
//        }
        
        
//        let firstButtonAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
//            print("First Button pressed")
//        })
//        let secondButtonAction = UIAlertAction(title: "从相册获取", style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
//            print("Second Button pressed")
//        })
//
//        EZAlertController.actionSheet("照片", message: "认真选择", sourceView: self.view, actions: [firstButtonAction, secondButtonAction])

        // With all actions in single closure
        EZAlertController.actionSheet("Title", message: "Message", sourceView: MBProgressHUD.getWindow(), buttons: ["First", "Second"]) { (alertAction, position) -> Void in
            if position == 0 {
                print("First button clicked")
            } else if position == 1 {
                print("Second button clicked")
            }
        }
        
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
