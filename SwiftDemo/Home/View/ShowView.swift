//
//  ShowView.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/6.
//

import UIKit
import SnapKit

class ShowView: ETPopupView {

    override func awakeFromNib() {
        super.awakeFromNib()
        type = .alert
//        ETPopupWindow.sharedWindow().touchWildToHide = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: kScreenWidth - 60, height: 380))
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.hide()
    }
}
