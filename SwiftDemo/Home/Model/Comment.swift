//
//  Comment.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/27.
//
//
import KakaJSON

struct Comment: Convertible {
    let floor: Int = 0
    let created_at: Int = 0
    let content:String = ""
    let parentId: Int = 0
    let likeCount: Int = 0
    let user: User! = nil
}
