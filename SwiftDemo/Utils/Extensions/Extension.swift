//
//  Extension.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/28.
//

import Foundation
/// 前缀类型
struct Mj<Base> {
    var base:Base
    init(_ base:Base) {
        self.base = base
    }
}

/// 利用协议扩展前缀属性
protocol MJCompatible { }
extension MJCompatible {
    static var mj: Mj<Self>.Type {
        set {}
        get { Mj<Self>.self }
    }
    var mj: Mj<Self> {
        set {}
        get { Mj(self) }
    }
}

/// 给扩展类继承协议实现前缀功能
extension String:MJCompatible {}

/// 给字符串扩展功能
extension Mj where Base == String {
    var numberCount: Int {
        var count = 0
        for c in self.base where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    
    static func run() {
        print("run")
    }
}

//
//class Frog { }
//
//extension Mj where Base:Frog {
//    func jump() {
//        print("jump")
//    }
//    static func run() {
//        print("run")
//    }
//}
//extension Frog:MJCompatible { }
//
//Frog.mj.run()
