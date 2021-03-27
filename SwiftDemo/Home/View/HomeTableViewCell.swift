//
//  HomeTableViewCell.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/27.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var label: UILabel!
    var itemModel:Item?
    
//    var item:Item {
//        set {
//            self.item = newValue
//            label.text = item.name
//        }
//        get {
//            self.item
//        }
//    }
    static let cellID = "HomeTableViewCellID"
    
    func initailData(item:Item)  {
        itemModel = item
        label.text = item.content
        let url = item.origin_url
        imageV.kf.setImage(with: URL(string: url))
        
    }
}
