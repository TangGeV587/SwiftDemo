//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit

class HomeViewController: UIViewController {
    
   var tableView = UITableView()
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier:HomeTableViewCell.cellID)
        view.addSubview(tableView)
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: loadNewData)
        tableView.mj_header?.beginRefreshing()
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: loadMoreData)
    }
    
    func loadNewData() {
        AF.request(API.imgrank,parameters: ["page":1,"count":1]).responseJSON {
            [weak self] response in
            switch response.result {
            case let .success(data):
//                guard let dict = data else {return}
                guard let jsons = JSON(data)["items"].arrayObject else {return}
              
                let models = modelArray(from:jsons, Item.self)
                self?.items.removeAll()
                self?.items.append(contentsOf: models)
                self?.tableView.reloadData()
                self?.tableView.mj_header?.endRefreshing()
                self?.page = 1
            case let .failure(error):
                print(error.errorDescription as Any)

            }
        }
    }
    
    func loadMoreData() {
        AF.request(API.imgrank, parameters: ["page": page + 1]).responseJSON {
            [weak self] response in
            switch response.result {
            case let .success(data):
//                guard let dict = data else {return}
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
}


extension HomeViewController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  items.count  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellID) as! HomeTableViewCell
        let item = self.items[indexPath.row]
        cell.item = item
//        cell.initailData(item: item)
        return cell
    }
}

extension HomeViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.items[indexPath.row].content)
    }
}
