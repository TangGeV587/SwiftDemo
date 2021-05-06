//
//  HttpError.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/12.
//

import Foundation

// 请求的错误反馈，继承`NSObject`为了让OC也能调用
public class HttpError: NSObject {
    /// 错误码
    @objc var code = -1
    /// 错误描述
    @objc var localizedDescription: String

    init(code: Int, desc: String) {
        self.code = code
        self.localizedDescription = desc
        super.init()
    }
}
