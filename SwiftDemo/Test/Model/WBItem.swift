//
//  WBItem.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//

import Foundation
struct WBItem: Convertible {
    let id: Int = 0
    let avatar: String = "" // image name
    let vip: Bool = false
    let name: String = ""
    let date: String = "" // yyyy-MM-dd HH:mm:ss
    
    var isFollowed: Bool = false
    
    let text: String = ""
    let images = [String]() // image names
    
    var commentCount: Int = 0
    var likeCount: Int = 0
    var isLiked: Bool = false
    var cellHeight:CGFloat = 82
    
    mutating func kj_didConvertToModel(from json: [String : Any]) {
        print(name)
        if images.count > 0 {
            let row = (images.count - 1 ) / 3 + 1
            cellHeight += CGFloat(row * 100 + (row - 1) * 10)
        }
    }
}


