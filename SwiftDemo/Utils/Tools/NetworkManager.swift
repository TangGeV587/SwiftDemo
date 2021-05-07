//
//  NetworkManager.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/4/1.
//

import Foundation
private let ApiBaseUrl = "https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/"

//typealias NetworkRequestResult = Result<Any,Error>
//typealias NetworkCompeletation = (NetworkRequestResult) -> Void
public typealias CompletionClosure = (_ code: Int, _ result: Any) -> Void

class NetworkManager {
    
    static let share = NetworkManager()
    private(set) var taskArray = [DataRequest]()//任务数组
    private init(){}
    
    var commonHeaders:HTTPHeaders = ["userId":"123","token":"xxxx"]
    /// 网络请求
    @discardableResult
    func httpRequest(path: String,
                    parameters: Parameters?,
                    completation: @escaping CompletionClosure ) -> DataRequest {
        var taskRequest = NetworkingRequest()
        let url = path.hasPrefix("http") ? path : ApiBaseUrl + path
        taskRequest.request = AF.request( url ,
                parameters: parameters,
                headers: commonHeaders,
                requestModifier:{$0.timeoutInterval = 15}
        ).responseJSON { response in
            switch response.result {
            case let .success(data):
                print( ApiBaseUrl + path + " 打印结果:\n" + JSONString(from: data, prettyPrinted: true))
                taskRequest.handReponse(response: data , completation: completation)
            case let .failure(error):
                taskRequest.handReponse(response: error , completation: completation)
            }
            if let index = self.taskArray.firstIndex(of:taskRequest.request!) {
                self.taskArray.remove(at: index)
            }
        }
        taskArray.append(taskRequest.request!)
        return taskRequest.request!
    }
    
    //MARK: -上传文件
    func uploadFileRequest(path: String,
                           method: HTTPMethod = .post,
                           parameters: Parameters?,
                           datas:[FileUploadData],
                           headers: [String: String]? = nil,
                           completation: @escaping (Result<Any,Error>) -> Void ) -> DataRequest {
        var h: HTTPHeaders?
        //"content-type":"multipart/form-data"
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        
        var taskRequest = NetworkingRequest()
        taskRequest.request =   AF.upload(multipartFormData: { multipartFormData in
            if let param = parameters {
                for (k,v) in param {
                    let value = v as! String
                    multipartFormData.append(value.data(using:.utf8)!, withName:k)
                }
            }
           
            for d in datas {
                multipartFormData.append(d.data, withName: d.name, fileName: d.fileName, mimeType: d.mimeType)
            }
            
        }, to:ApiBaseUrl + path, method: .post, headers: h).uploadProgress(queue: .main, closure: { progress in
            print(progress)
        }).validate().responseJSON { response in
            
            switch response.result {
            case let .success(data):
                completation(.success(data))
            case let .failure(error):
                completation(.failure(error))
            }
            if let index = self.taskArray.firstIndex(of:taskRequest.request!) {
                self.taskArray.remove(at: index)
            }
        }
        taskArray.append(taskRequest.request!)
        return taskRequest.request!
    }
    
//    @discardableResult
//    func requestPost(path: String,
//                    parameters: Parameters?,
//                    completation: @escaping (Swift.Result<Any,Error>) -> Void ) -> DataRequest {
//        AF.request( ApiBaseUrl + path,
//                 method: .post,
//                parameters: parameters,
//                encoding: JSONEncoding.prettyPrinted,
//                headers: commonHeaders,
//                requestModifier:{$0.timeoutInterval = 15}
//        ).responseJSON { response in
//            switch response.result {
//            case let .success(data):
//                completation(.success(data))
//            case let .failure(error):
//                completation(self.handleError(error))
//            }
//        }
//
//    }
}

//MARK: - 自定义请求
struct NetworkingRequest {
    var request: DataRequest?
    // private var resultHandler: CompletionClosure?
    
    func handReponse(response: Any,completation: @escaping CompletionClosure ) {
        if response is AFError {
            completation(0,handleError(response as! AFError))
        }else {
            let dict = JSON(response).dictionaryObject!
            
            let code = ((dict["err"] ?? dict["code"]) ?? -1) as! Int
            if code == 0 || code == 200 {
                completation(code, response)
            }else {
                let desc = dict["message"] as? String ?? "报错了"
                completation(code,HttpError(code: code, desc: desc))
            }
        }
    }
    
    
    //MARK: - 处理错误
    private func handleError(_ error: AFError) -> HttpError {
        var httpError:HttpError
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            let desc:String
            if  code == -1001 || code == -2102 {
                desc = "网络请求超时～"
            }else if case 100...999 = code  {
                desc =  "服务器开小差了～"
            }else if  code == -1004 || code == -1005 {
                desc =  "无法连接服务器～"
            }else if code == -1011 {
                desc =  "服务器开小差了～"
            }else if code == -1009 || code == -1020{
                desc = "网络连接失败"
            }else {
                desc = "\(nserror.localizedDescription):\(code)"
            }
            httpError = HttpError(code: code, desc:desc)
        }else {
            httpError = HttpError(code: 0, desc:"自定义错误")
        }
        return httpError
    }
}
