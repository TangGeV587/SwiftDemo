//
//  WaterFlowController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/3/29.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

class WaterFlowController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var channelStr:String?
    var collectionView = UICollectionView(frame:.zero, collectionViewLayout: UICollectionViewLayout())
    let model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.buildDataSource()
        //Layout setup
        setupCollectionView()
        //Register nibs
        registerNibs()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: - CollectionView UI Setup
    func setupCollectionView(){
       
        collectionView.dataSource  = self
        collectionView.delegate = self
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 4.0
        layout.minimumInteritemSpacing = 4.0
        layout.columnCount = 2
        // Collection view attributes
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        // Add the waterfall layout to your collection view
        collectionView.collectionViewLayout = layout
        view.addSubview(collectionView)
    }
    
    // Register CollectionView Nibs
    func registerNibs(){
        
        // attach the UI nib file for the ImageUICollectionViewCell to the collectionview
        let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: - CollectionView Delegate Methods
    
     //** Number of Cells in the CollectionView */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.images.count
    }
    
    
    //** Create a basic CollectionView Cell */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create the cell and return the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageUICollectionViewCell
        // Add image to cell
        cell.image.image = model.images[indexPath.row]
        return cell
    }
    
    
}

extension WaterFlowController:CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = model.images[indexPath.row].size
        
        return imageSize
    }
}


extension WaterFlowController:IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: channelStr )
      
      }
}
