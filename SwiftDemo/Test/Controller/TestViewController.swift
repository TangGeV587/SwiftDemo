//
//  TestViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/31.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var dataArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(HomeCell.reuseIdentify)
        setupUI()
//       setupData3()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupUI() {
        navigationItem.title = "测试"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("提示", target: self, action: #selector(clickAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("模型", target: self, action: #selector(modelAction))
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(setupData3))
        tableView.mj_header?.beginRefreshing()
    }
    
    
   @objc func setupData3() {
        let url = "PostListData_recommend_1.json"
    NetworkManager.share.httpRequest(path: url, parameters: nil) {
        [weak self] (code, response) in
        self?.tableView.mj_header?.endRefreshing()
        if code == 0 || code == 200 {
            guard  let json = JSON(response)["list"].arrayObject else {
                self?.showErrorMsg("数据解析失败")
                return
            }
            
            let modelsArray =  modelArray(from: json, type: WBItem.self)
            self?.dataArray .removeAll()
            self?.dataArray.append(contentsOf:modelsArray)
            self?.tableView.reloadData()
        }else {
            let error = response as! NSError
            self?.showErrorMsg(error.localizedDescription)
        }

//        NetworkManager.share.requestGet(path: url, parameters: nil) { response in
//            switch response. {
//            case let .success(data):
////                let json = JSON(data)
//                if let json = JSON(data).dictionaryObject {
//                    modelArray(from:json,WBlist.self)
//                }
//
//
//                guard let list = try?JSONDecoder().decode(PostList.self, from: data) else {
//                    self.showErrorMsg("数据解析失败")
//                    return
//                }
//                self.showErrorMsg("\(list.list.count)条数据")
//            case let .failure(error):
//
//                self.showErrorMsg(error.localizedDescription)
//
//            }
        }
    }
    
    func showErrorMsg(_ text:String)  {
        DispatchQueue.main.async {
            self.label.text = text
        }
    }
    
   
    //MARK: - action
    @objc func modelAction() {
        
        self.navigationController?.pushViewController(TestModelController(), animated: true)
    }
    
    @objc func clickAction() {
        let view = Bundle.loadView(fromNib: "ShowView", with: ShowView.self)
        view.attachedView = MBProgressHUD.getWindow()
        view.show()
    }
    
    
//    MARK:- lazy
    lazy var tableView:UITableView  = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName:"HomeCell", bundle: nil), forCellReuseIdentifier: HomeCell.reuseIdentify)
        view.addSubview(tableView)
        return tableView
    }()
    
}

extension TestViewController :UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.reuseIdentify) as! HomeCell
        cell.item = self.dataArray[indexPath.item] as? WBItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.dataArray[indexPath.row] as! WBItem
        return item.cellHeight
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SystemInfo.callToNum(numString: "15068848741")
    }
}

/*
 
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
 
 */
