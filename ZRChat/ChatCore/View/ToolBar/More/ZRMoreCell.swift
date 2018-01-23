//
//  ZRMoreCell.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/19.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ZRMoreCell: UICollectionViewCell {
    
    var model = ZRMoreModel(imageStr: "", title: "") {
        didSet {
            self.titleLabel.text = model.title
            guard model.imageStr != "", let image = UIImage(named: model.imageStr) else {
                self.imageView.image = nil
                return
            }
            self.imageView.image = image
        }
    }
    
    fileprivate lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(0x555555)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let space: CGFloat = 20
        let itemWidth = (UIScreen.main.bounds.width - 8 * space) / 4
        self.addSubview(imageView)
        let imgH = "H:|-\(space)-[imageView]-\(space)-|"
        let imgV = "V:|-10-[imageView(\(itemWidth))]"
        let imgConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: imgH, options: .alignAllBottom, metrics: nil, views: ["imageView": imageView])
        let imgConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: imgV, options: .alignAllBottom, metrics: nil, views: ["imageView": imageView])
        self.addConstraints(imgConstraintsH + imgConstraintsV)
        
        self.addSubview(titleLabel)
        let lblH = "H:|-7-[titleLabel]-7-|"
        let lblV = "V:[titleLabel(20)]-0-|"
        let lblConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: lblH, options: .alignAllBottom, metrics: nil, views: ["titleLabel": titleLabel])
        let lblConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: lblV, options: .alignAllBottom, metrics: nil, views: ["titleLabel": titleLabel])
        self.addConstraints(lblConstraintsH + lblConstraintsV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
