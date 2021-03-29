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
    @objc dynamic var name:String?
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sliderV: UISlider!
    @IBOutlet weak var buttonn: UIButton!
    
    let data = Observable.just([
        Person(name: "Jack", age: 10),
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
        view.backgroundColor = UIColor.yellow
    }
    
    func test9() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        data.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: UITableViewCell.self)) {
            row ,person,cell in
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = "\(person.age)"
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            print(indexPath.row)
        }).disposed(by:bag)
        
//        tableView.rx.modelSelected(Person.self).subscribe(onNext: { person in
//            print(person.name)
//        }).disposed(by: bag)
        
    }
    
    func test8() {
//        Observable.just(0.8).bind(to: sliderV.rx.value).dispose()
//        sliderV.rx.value.map{"\($0)" }.bind(to: textField.rx.text).disposed(by: bag)
        
        textField.rx.text.subscribe(onNext:{
            text in
            print(text ?? "nil")
        }).disposed(by: bag)
        
    }
    
    func test7() {
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification).subscribe(onNext:{
            nofification in
            print("UIApplication 进入后台",nofification)
        }).disposed(by: bag)
        
    }
    
    func test6()  {
        
        self.rx.observe(String.self, "name").subscribe(onNext: {
            name in
            print("name is ", name ?? "nil")
        }).disposed(by: bag)
        self.name = "Rose"
    }
    
    func test5()  {
        buttonn.rx.controlEvent(.touchUpInside).subscribe(onNext:{
            print("按钮被点击了")
        }).disposed(by: bag)
    
    }
    
    
    func test4()  {
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        observable.map{ $0 % 2 == 0 }.bind(to:buttonn.rx.isHidden).disposed(by:bag)
    }
    
    func test3()  {
        let binder = Binder<String>(label) { (label, text) in
            label.text = text
        }
      
        Observable.just(1).map{ "数值是:\($0)" }.bind(to: binder).dispose()
    }
    
    func test2()  {
        
        let observer = AnyObserver<Int>.init { event in
            switch event {
            case .next(let data):
                print("next ",data)
            case .completed:
                print("completed")
            case .error(let error):
                print("error ",error)
            }
        }
        
        Observable.just(1).subscribe(observer).disposed(by: bag)
        
    }
    
    func test1()  {
        //定时器
        let observable = Observable<Int>.timer(.seconds(2), period:.seconds(1),scheduler: MainScheduler.instance)
        
        //订阅事件
//        observable.subscribe(onNext: {
//            print("onNext",$0)
//        }, onError: {
//            print("onError",$0)
//        }, onCompleted: {
//            print("onCompleted")
//        }, onDisposed: {
//            print("onDisposed")
//        })
        
        observable.map{"计时:\($0)"}.bind(to:label.rx.text).disposed(by: bag)
    }
    
    func test()  {
        //发送事件
//        let observable = Observable<Int>.create { observer in
//            observer.onNext(1)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//        let observable = Observable.just(1) //发完就结束
//        let observable = Observable.of(1) //发完就结束
//        let observable = Observable.from([1,2]) //发完就结束
        
        
        let observable = Observable<Int>.create { observer  in
            observer.onNext(1)
            observer.onError(MJError.test)
            observer.onNext(2)
            observer.onCompleted()
            observer.onNext(3)
            return Disposables.create()
        }
//
//        let observable = Observable.of(1,2,3)
//        let observable = Observable.from([1,2,3])
       
        //订阅事件,表示只订阅一次
        observable.subscribe { event in
            print(event)
        }.dispose()
        
//        observable.subscribe(onNext: {
//            print("onNext",$0)
//        }, onError: {
//            print("onError",$0)
//        }, onCompleted: {
//            print("onCompleted")
//        }, onDisposed: {
//            print("onDisposed")
//        }).dispose()
    }
}
