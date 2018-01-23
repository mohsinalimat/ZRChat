//
//  ZREmotionView.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/16.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ZREmotionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    private let itemHeight: CGFloat = 50
    private let sectionNumbers = 23
    private let numberOfOneLine: CGFloat = 8
    static let defaultH: CGFloat = 216

    fileprivate lazy var pageControl: UIPageControl = {
        var view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.currentPageIndicatorTintColor = UIColor.darkGray
        view.pageIndicatorTintColor = UIColor.lightGray
        return view
    }()
    
    fileprivate lazy var sendBtn: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("发送", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor(0x555555), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor(0xC2C3C7).cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        return button
    }()
    
    var dataSource = [ZREmojisModel]() {
        didSet {
            if dataSource.count % sectionNumbers == 0 {
                self.pageControl.numberOfPages = dataSource.count / sectionNumbers
            } else {
                self.pageControl.numberOfPages = dataSource.count / sectionNumbers + 1
            }
        }
    }
    
    @objc fileprivate func sendAction() {
        // 发送
        self.collectionView.emotionDelegate?.emotionScrollViewSend()
    }
    
    lazy var collectionView: ZREmotionCollectionView = {

        let itemWidth = (UIScreen.main.bounds.width - 10 * 2) / numberOfOneLine
        let padding = (UIScreen.main.bounds.width - numberOfOneLine * itemWidth) / 2.0
        let paddingLeft = padding
        let paddingRight = UIScreen.main.bounds.width - paddingLeft - itemWidth * numberOfOneLine
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)
        
        var view = ZREmotionCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        view.register(ZREmojisCell.self, forCellWithReuseIdentifier: "EMOJIESCELL")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(0xEFF0F5)
        self.addSubview(collectionView)
        
        let h = "H:|-0-[collectionView]-0-|"
        let v = "V:|-0-[collectionView]-50-|"
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: h, options: .alignAllBottom, metrics: nil, views: ["collectionView": collectionView])
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: v, options: .alignAllBottom, metrics: nil, views: ["collectionView": collectionView])
        self.addConstraints(constraintsH + constraintsV)
        
        self.addSubview(pageControl)
        let pageH = "H:|-0-[pageControl]-0-|"
        let pageV = "V:[pageControl(40)]-0-|"
        let pageHC = NSLayoutConstraint.constraints(withVisualFormat: pageH, options: .alignAllBottom, metrics: nil, views: ["pageControl": pageControl])
        let pageVC = NSLayoutConstraint.constraints(withVisualFormat: pageV, options: .alignAllBottom, metrics: nil, views: ["pageControl": pageControl])
        self.addConstraints(pageHC + pageVC)
        
        self.pageControl.numberOfPages = dataSource.count
        
        self.addSubview(sendBtn)
        let btnH = "H:[sendBtn(46)]-10-|"
        let btnV = "V:[sendBtn(30)]-5-|"
        let btnHC = NSLayoutConstraint.constraints(withVisualFormat: btnH, options: .alignAllBottom, metrics: nil, views: ["sendBtn": sendBtn])
        let btnVC = NSLayoutConstraint.constraints(withVisualFormat: btnV, options: .alignAllBottom, metrics: nil, views: ["sendBtn": sendBtn])
        self.addConstraints(btnHC + btnVC)
    }
    
    fileprivate func emoticonForIndexPath(_ indexPath: IndexPath) -> ZREmojisModel? {
        let reIndex = indexPath.section * sectionNumbers + (indexPath.row % 3) * Int(numberOfOneLine) + (indexPath.row / 3)
        guard reIndex < self.dataSource.count else { return nil }
        return self.dataSource[reIndex]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Collection Delegate & DataSource
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
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMOJIESCELL", for: indexPath) as! ZREmojisCell
        
        if indexPath.row == 23 {
            cell.emojisModel = ZREmojisModel(imageName: "zr_delete", text: "", type: .delete)
        } else {
            if let model = emoticonForIndexPath(indexPath) {
                cell.emojisModel = model
            } else {
                cell.emojisModel = ZREmojisModel(imageName: "", text: "", type: .normal)
            }
        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.bounds.width
        self.pageControl.currentPage = Int(self.collectionView.contentOffset.x / pageWidth)
    }
}
