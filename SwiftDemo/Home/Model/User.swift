//
//  User.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/27.
//

struct User:Convertible {
    
    let thumb: String = ""
    let medium: String = ""
    let age: Int = 0
    let id: String = ""
    let name: String = ""
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        if property.name == "name" { return "login" }
        return property.name
    }
}
