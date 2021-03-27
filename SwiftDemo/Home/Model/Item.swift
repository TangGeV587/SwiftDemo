//
//  Item.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/27.
//
import KakaJSON

struct Item: Convertible {
    let thumb: String = ""
    let medium: String = ""
    let age: Int = 0
    let id: String = ""
    let name: String = ""
    let content: String = ""
    let origin_url: String = ""
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
}


