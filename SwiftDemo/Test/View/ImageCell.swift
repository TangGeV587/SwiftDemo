//
//  ImageCell.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    var url:String? {
        
        didSet {
            imageV.kf.setImage(with: URL(string: url!), placeholder:UIImage(named: "pick_placeholder"))
        }
    }
}
