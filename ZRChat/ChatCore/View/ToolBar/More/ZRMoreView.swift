//
//  ZRMoreView.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/16.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ZRMoreView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    // 一排4个选项
    fileprivate let numberOfOneLine: CGFloat = 4
    // 一页8个选项
    fileprivate let sectionNumbers = 8
    static let defaultH: CGFloat = 216
    
    fileprivate lazy var pageControl: UIPageControl = {
        var view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentPageIndicatorTintColor = UIColor.darkGray
        view.pageIndicatorTintColor = UIColor.lightGray
        return view
    }()
    
    lazy var collectionView: ZRMoreCollectionView = {
        
        let itemWidth = UIScreen.main.bounds.width / numberOfOneLine
        let padding = (UIScreen.main.bounds.width - numberOfOneLine * itemWidth) / 2.0
        let itemHeight = (ZRMoreView.defaultH - 40) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        var view = ZRMoreCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(ZRMoreCell.self, forCellWithReuseIdentifier: "MORESCELL")
        return view
    }()
    
    var dataSource = [ZRMoreModel]() {
        didSet {
            if dataSource.count % sectionNumbers == 0 {
                self.pageControl.numberOfPages = dataSource.count / sectionNumbers
            } else {
                self.pageControl.numberOfPages = dataSource.count / sectionNumbers + 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(0xEFF0F5)
        self.addSubview(collectionView)
        
        let h = "H:|-0-[collectionView]-0-|"
        let v = "V:|-0-[collectionView]-40-|"
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: h, options: .alignAllBottom, metrics: nil, views: ["collectionView": collectionView])
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: v, options: .alignAllBottom, metrics: nil, views: ["collectionView": collectionView])
        self.addConstraints(constraintsH + constraintsV)
        
        self.addSubview(pageControl)
        let pageH = "H:|-0-[pageControl]-0-|"
        let pageV = "V:[pageControl(40)]-0-|"
        let pageHC = NSLayoutConstraint.constraints(withVisualFormat: pageH, options: .alignAllBottom, metrics: nil, views: ["pageControl": pageControl])
        let pageVC = NSLayoutConstraint.constraints(withVisualFormat: pageV, options: .alignAllBottom, metrics: nil, views: ["pageControl": pageControl])
        self.addConstraints(pageHC + pageVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    fileprivate func moreForIndexPath(_ indexPath: IndexPath) -> ZRMoreModel? {
        let reIndex = indexPath.section * sectionNumbers + (indexPath.row % 2) * Int(numberOfOneLine) + (indexPath.row / 2)
        guard reIndex < self.dataSource.count else { return nil }
        return self.dataSource[reIndex]
    }
    
    // MARK: - Collection Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var sections = dataSource.count / sectionNumbers
        if dataSource.count % sectionNumbers != 0 {
            sections += 1
        }
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionNumbers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MORESCELL", for: indexPath) as! ZRMoreCell
        guard let model = moreForIndexPath(indexPath) else {
            cell.model = ZRMoreModel(imageStr: "", title: "")
            return cell
        }
        cell.model = model
        return cell
    }
    
    // MARK: - Scroll View Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.bounds.width
        self.pageControl.currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
    }
}
