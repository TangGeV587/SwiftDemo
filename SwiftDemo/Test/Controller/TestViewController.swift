//
//  TestViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/31.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
       setupData2()
    }
    
   func setupUI() {
    navigationItem.title = "测试"
    view.backgroundColor = .white
    }

//    func setupData() {
//        var dict = [String:Any]()
//        dict["page"] = 1
//        request(API.imgrank, parameters:dict).responseJSON {
////        Alamofire.request(API.imgrank, method:.get, parameters: dict , encoding:JSONEncoding.default ).response {
//            response in
//            print(response)
//        }
//    }
    
    func setupData2() {
        let url = "PostListData_recommend_1.json"
        NetworkManager.share.requestGet(path: url, parameters: nil) { result in
            switch result {
            case let .success(data):
                let jsonStr = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                print(jsonStr!)
                guard let list = try?JSONDecoder().decode(PostList.self, from: data) else {
                        self.showErrorMsg("数据解析失败")
                        return
                    }
                    self.showErrorMsg("\(list.list.count)条数据")
            case let .failure(error):
                
                self.showErrorMsg(error.localizedDescription)
            
        }
    }
    }
    
    func setupData1() {
        let url = URL(string:"https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/PostListData_recommend_1.json")!
        //responseJSON 返回结果就是字典或者数组
        AF.request(url).responseData { response in
            //主线程执行
//            response.result //枚举类型
            switch response.result {
            case let .success(data):
            guard let list = try?JSONDecoder().decode(PostList.self, from: data) else {
                    self.showErrorMsg("数据解析失败")
                    return
                }
                self.showErrorMsg("\(list.list.count)条数据")
            case let .failure(error):
                self.showErrorMsg(error.localizedDescription)
            }
        }
        
//        var request = URLRequest(url: url)
//        request.timeoutInterval = 20
//        request.httpMethod = "POST"
//        let dict = ["key":"data"]
//        //请求体
//        let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        request.httpBody = data
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                self.showErrorMsg(error.localizedDescription)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode == 200 else {
//                self.showErrorMsg("请求出错")
//                return
//            }
//
//            guard let data = data else {
//                self.showErrorMsg("没有数据")
//                return
//            }
//
//            guard let list = try?JSONDecoder().decode(PostList.self, from: data) else {
//                self.showErrorMsg("数据解析失败")
//                return
//            }
//            print(httpResponse)
//            self.showErrorMsg("\(list.list.count)条数据")
//
//        }
//      task .resume()
        
    }
    
    func setupData() {
        let url = URL(string:"https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/PostListData_recommend_1.json")!

       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.showErrorMsg(error.localizedDescription)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode == 200 else {
                self.showErrorMsg("请求出错")
                return
            }

            guard let data = data else {
                self.showErrorMsg("没有数据")
                return
            }

            guard let list = try?JSONDecoder().decode(PostList.self, from: data) else {
                self.showErrorMsg("数据解析失败")
                return
            }
            print(httpResponse)
            self.showErrorMsg("\(list.list.count)条数据")

        }
      task .resume()
        
    }
    
    
    func showErrorMsg(_ text:String)  {
        DispatchQueue.main.async {
            self.label.text = text
        }
    }
    
    //https://github.com/xiaoyouxinqing/PostDemo/raw/master/PostDemo/Resources/PostListData_recommend_1.json
}
