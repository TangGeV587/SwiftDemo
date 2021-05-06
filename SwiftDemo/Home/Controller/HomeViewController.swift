//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class HomeViewController: UIViewController {
    
   var items = [Item]()
   var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func setupUI() {
        navigationItem.title = "首页"
        view.backgroundColor = UIColor.red
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("入口", target: self, action: #selector(clickAction))
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: loadNewData)
        tableView.mj_header?.beginRefreshing()
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: loadMoreData)
    }
    
    func loadNewData() {
        MBProgressHUD.showLoadActivity(msg: "加载中...", view: self.navigationController?.view)
        NetworkManager.share.httpRequest(path: API.imgrank, parameters:  ["page":1,"count":1]) {
            [weak self] (code, response) in
            self?.tableView.mj_header?.endRefreshing()
            if code == 0 || code == 200 {
                MBProgressHUD.hide(for: (self?.navigationController?.view)!, animated: true)
//                guard let dict = data else {return}
//                let jsons = JSON(data)["items"].arrayObject!
                guard let jsons = JSON(response)["items"].arrayObject else {return}
                let models = modelArray(from:jsons, Item.self)
                self?.items.removeAll()
                self?.items.append(contentsOf: models)
                
                if let a = self?.items.count {
                    print(a)
                    self?.tableView.reloadData()
                }else {
                    self?.tableView.emptyManager.error = nil
                    self?.tableView.reloadEmptyDataSet()
                }
                
                self?.tableView.mj_header?.endRefreshing()
                self?.page = 1
            }else {
                print(response.self)
                let error = response as! NSError
                
                self?.tableView.emptyManager.error = error
                self?.tableView.reloadEmptyDataSet()
                MBProgressHUD.showRequestMessage(msg:error.localizedDescription , view: self?.navigationController?.view)
            }
            
        }
        
        
//        AF.request(API.imgrank,parameters: ["page":1,"count":1]).responseJSON {
//            [weak self] response in
//            MBProgressHUD.showRequestMessage(msg: "请求成功", view: self?.navigationController?.view)
//            switch response.result {
//            case let .success(data):
////                guard let dict = data else {return}
////                let jsons = JSON(data)["items"].arrayObject!
//                guard let jsons = JSON(data)["items"].arrayObject else {return}
//                let models = modelArray(from:jsons, Item.self)
//                self?.items.removeAll()
//                self?.items.append(contentsOf: models)
//                self?.tableView.reloadData()
//                self?.tableView.mj_header?.endRefreshing()
//                self?.page = 1
//            case let .failure(error):
//                MBProgressHUD.showRequestMessage(msg:error.errorDescription! , view: self?.navigationController?.view)
//                print(error.errorDescription as Any)
//            }
//        }
    }
    
    func loadMoreData() {
        AF.request(API.imgrank, parameters: ["page": page + 1]).responseJSON {
            [weak self] response in
            switch response.result {
            case let .success(data):
//              guard let dict = data else {return}
                guard let jsons = JSON(data)["items"].arrayObject else {return}
                let models = jsons.kj.modelArray(Item.self)
                self?.items.append(contentsOf: models)
                self?.tableView.reloadData()
                self?.tableView.mj_footer?.endRefreshing()
                self?.page += 1
            case let .failure(error):
                print(error.errorDescription as Any)

            }
            
        }
    }
    
    
    //MARK: - action
    @objc func clickAction() {
        
        navigationController?.pushViewController(ButtonViewController(), animated: true)
    }
    
    lazy var tableView:TableView = {
       let tableView = TableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier:HomeTableViewCell.cellID)
        view.addSubview(tableView)
        return tableView
    }()
}


extension HomeViewController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  items.count  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellID) as! HomeTableViewCell
        let item = self.items[indexPath.row]
        cell.item = item
//      cell.initailData(item: item)
        return cell
    }

}

extension HomeViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(AlertViewController(), animated: true)
        
//        print(self.items[indexPath.row].content)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        SystemInfo.callToNum(numString: "15068848741")
    }
}
