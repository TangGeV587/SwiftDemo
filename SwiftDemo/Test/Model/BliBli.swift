//
//  BliBli.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/4/7.
//

import Foundation
struct Top:Convertible {
    let interval : Int = 0
    let moduleList : [ModuleInfo] = [ModuleInfo]()

    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
    
}


struct ModuleInfo:Convertible {
    let list : [ListItem] = [ListItem]()
    let module_info : MouduleItem? = nil
    var cellHeight:CGFloat = 82
    
    mutating func kj_didConvertToModel(from json: [String : Any]) {
        if list.count > 0 {
            let row = (list.count - 1 ) / 3 + 1
            cellHeight += CGFloat(row * 100 + (row - 1) * 10)
        }
    }
}

struct MouduleItem:Convertible {
    let areaV2Id : Int = 0
    let areaV2ParentId : Int? = 0
    let count : Int = 0
    let id : Int = 0
    let link : String = ""
    var pic : String = ""
    
    let sort : Int = 0
    let title : String? = ""
    let type : Int = 0
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        switch property.name {
        case "pic":
            print(property.name)
            return  ["pic","cover"]
        case "cover":
            print(property.name)
            return  ["pic","cover"]
        default:
          return property.name
        }
    }

}

struct ListItem:Convertible {
    let id : String = ""
        let link : String = ""
        var pic : String?
        let title : String = ""
        var cover : String?
}

