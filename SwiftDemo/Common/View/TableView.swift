//
//  TableView.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/5.
//

import UIKit

class TableView: UITableView {

   lazy var emptyManager = EmptyDataManager()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.emptyDataSetSource = emptyManager
        self.emptyDataSetDelegate = emptyManager
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.emptyDataSetSource = emptyManager
        self.emptyDataSetDelegate = emptyManager
//        fatalError("init(coder:) has not been implemented")
    }
    
}
