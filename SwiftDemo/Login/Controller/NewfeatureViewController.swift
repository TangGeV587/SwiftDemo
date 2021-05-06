//
//  NewfeatureViewController.swift
//  Weibo
//
//  Created by xiaomage on 15/10/22.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit


class NewfeatureViewController: UICollectionViewController {

    let XMGNewfeatureReuseIdentifier =  "XMGNewfeatureReuseIdentifier"
    /// 新特性界面的个数
    let maxImageCount = 4
    /// 自定义布局
    let layout:NewfeatureLayout = NewfeatureLayout()
    
    init()
    {
        super.init(collectionViewLayout: layout)
        collectionView.register(NewfeatureCell.self, forCellWithReuseIdentifier: XMGNewfeatureReuseIdentifier)
//        NotificationCenter.default.addObserver(self, selector: #selector(printAction), name: NSNotification.Name(rawValue: "XMGSwitchRootViewController"), object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
//    @objc func printAction(){
//        print("点击了按钮")
//    }
//    XMGSwitchRootViewController
    
}

// MAKR: - 数据源方法
extension NewfeatureViewController
{
    // 1.当前组多少行
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        maxImageCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMGNewfeatureReuseIdentifier, for: indexPath) as! NewfeatureCell
        cell.fn = {
            [weak self] in
            self?.view.window?.rootViewController = TabbarController()
//            print("点击了按钮")
            
        }
        cell.index = indexPath.item
        cell.startButton.isHidden = indexPath.item != (maxImageCount - 1)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 该方法传入的indexPath是上一页的indexPath
        // 1.拿到当前页索引
       
        let path =  IndexPath(item: indexPath.item + 1, section: 0)
        // 2.拿到当前页cell
        if let cell = collectionView.cellForItem(at: path) as? NewfeatureCell {
            cell.startButton.isUserInteractionEnabled = false
            cell.startButton.transform =    CGAffineTransform(scaleX: 0.0, y: 0.0)
            
            UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options:.layoutSubviews) {
                cell.startButton.transform = .identity
            } completion: { _ in
                cell.startButton.isUserInteractionEnabled = true
            }
        }
    }
    }
    
// MAKR: - 自定义cell
class NewfeatureCell: UICollectionViewCell {
    var fn:(() -> Void)?
    /// 当前图片索引
    var index: Int?
        {
        didSet{
            // 设置图片
            pageView.image = UIImage(named: "new_feature_\(index! + 1)")
        }
    }
    
    // MAKR: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 内部控制方法
    /// 初始化UI
    private func setupUI()
    {
        // 1.添加子控件
        contentView.addSubview(pageView)
        contentView.addSubview(startButton)
        
        // 2.布局子控件
        pageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        startButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-200)
        }
    }
    /// 监听开始按钮点击
    @objc private func startBtnClick()
    {
        
        if let callback = fn {
            callback ()
        }
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "XMGSwitchRootViewController"), object: self)
        // 发送通知切换控制器
//        NotificationCenter.defaultCenter().postNotificationName(XMGSwitchRootViewController, object: self, userInfo: nil)
    }
    
    // MARK: - 懒加载
    /// 图片容器
    private lazy var pageView: UIImageView = UIImageView()
    
    /// 开始按钮
    lazy var startButton: UIButton = {
       let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), for: .normal)
        btn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
//        btn.addTarget(self, action: #selector("startBtnClick"), forControlEvents:.touchUpInside)
        return btn
    }()
}

// MAKR: - 自定义布局
class NewfeatureLayout: UICollectionViewFlowLayout
{
    // 2.准备布局
    override func prepare() {
        // 2.1设置layout
        itemSize = UIScreen.main.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        // 2.2设置collectionView
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
    }
}
