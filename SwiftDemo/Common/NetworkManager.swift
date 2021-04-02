//
//  NetworkManager.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/4/1.
//

import Foundation
private let ApiBaseUrl = "https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/"

typealias NetworkRequestResult = Swift.Result<Data,Error>
typealias NetworkCompeletation = (NetworkRequestResult) -> Void


class NetworkManager {
    
    static let share = NetworkManager()
    
    private init(){}
    
    var commonHeaders:HTTPHeaders = ["userId":"123","token":"xxxx"]
    
    
    @discardableResult
    func requestGet(path: String,
                    parameters: Parameters?,
                    completation: @escaping (Swift.Result<Data,Error>) -> Void ) -> DataRequest {
        AF.request( ApiBaseUrl + path,
                parameters: parameters,
                headers: commonHeaders,
                requestModifier:{$0.timeoutInterval = 15}
        ).responseData { response in
            switch response.result {
            case let .success(data):
                completation(.success(data))
            case let .failure(error):
                completation(.failure(error))
            }
        }
        
    }
    
    @discardableResult
    func requestPost(path: String,
                    parameters: Parameters?,
                    completation: @escaping (Swift.Result<Data,Error>) -> Void ) -> DataRequest {
        AF.request( ApiBaseUrl + path,
                 method: .post,
                parameters: parameters,
                encoding: JSONEncoding.prettyPrinted,
                headers: commonHeaders,
                requestModifier:{$0.timeoutInterval = 15}
        ).responseData { response in
            switch response.result {
            case let .success(data):
                completation(.success(data))
            case let .failure(error):
                completation(.failure(error))
            }
        }
        
    }
}
