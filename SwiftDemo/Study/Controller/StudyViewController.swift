//
//  StudyViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/26.
//

import UIKit
import RxSwift
import RxCocoa

enum MJError : Error {
    case test
}

struct Person {
    var name: String
    var age: Int
}

class StudyViewController: UIViewController {
    let bag = DisposeBag() //等袋子销毁的时候 才会取消订阅
    @IBOutlet weak var tableView: UITableView!
    
    let data = Observable.just([
        Person(name: "Transition", age: 10),
        Person(name: "Rose", age: 20),
        Person(name: "Kitty", age: 30),
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        test9()
    }
    
    func setupUI() {
        navigationItem.title = "学习"
    }
    
    func test9() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        data.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: UITableViewCell.self)) {
            row ,person,cell in
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = "\(person.age)"
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Person.self).subscribe(onNext:{ person in
            let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
            let vcNameStr = person.name + "Controller"
            let className = NSClassFromString("\(workName).\(vcNameStr)") as! UIViewController.Type
            self.navigationController?.pushViewController(className.init(), animated: true)
            
        }).disposed(by: bag)
        
        
        
        tableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            print(indexPath.row)
        }).disposed(by:bag)
        
    }
    
}
