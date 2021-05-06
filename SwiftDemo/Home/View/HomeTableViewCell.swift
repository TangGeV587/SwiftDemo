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
    
    var item:Item? = nil  {
        didSet {
//            initailData(item: item)
            
            label.text = item?.content
            guard let url = item?.origin_url else { return  }
            imageV.kf.setImage(with: URL(string: url), placeholder:UIImage(named: "pick_placeholder"))
        }
    }
    static let cellID = "HomeTableViewCellID"
    
    func initailData(item:Item)  {
        label.text = item.content
        let url = item.origin_url
        imageV.kf.setImage(with: URL(string: url))
        
    }
}
