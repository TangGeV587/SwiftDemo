//
//  HomeCell.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/3.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var cotentL: UILabel!
    @IBOutlet weak var collectionV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let width:CGFloat = 100.0
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = (kScreenWidth - 3 * width - 30) / 2
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero
//        collectionV
        print(ImageCell.reuseIdentify)
        collectionV.register(UINib(nibName:"ImageCell", bundle: nil), forCellWithReuseIdentifier: ImageCell.reuseIdentify)
        collectionV.collectionViewLayout = layout
    }
    
    var item:WBItem? {
        didSet {
            nameL.text = item?.name
            cotentL.text = item?.text
            collectionV.reloadData()
        }
    }
    var module:ModuleInfo? {
        
        didSet {
            nameL.text = module?.module_info?.title
            cotentL.text = "xxxxxxxxx"
            collectionV.reloadData()
        }
    }
    
    
}

extension HomeCell: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if item != nil {
            return item?.images.count ?? 0
        }else {
            return module?.list.count ?? 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentify, for: indexPath) as! ImageCell
        if let _ = module {
            if let url = module?.list[indexPath.item].pic ?? module?.list[indexPath.item].cover {
                cell.url = url
            }
        }
        return cell
    }
    
}
