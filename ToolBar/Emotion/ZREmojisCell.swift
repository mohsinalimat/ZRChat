//
//  ZREmojisCell.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/18.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ZREmojisCell: UICollectionViewCell {
    
    var emojisModel = ZREmojisModel(imageName: "", text: "", type: .normal) {
        didSet {
            guard emojisModel.imageName != "" else {
                self.imageView.image = nil
                return
            }
            self.imageView.image = UIImage(named: emojisModel.imageName)
            self.imageView.contentMode = .scaleAspectFit
        }
    }
    
    fileprivate lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        let h = "H:|-7-[imageView]-7-|"
        let v = "V:|-10-[imageView]-10-|"
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: h, options: .alignAllBottom, metrics: nil, views: ["imageView": imageView])
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: v, options: .alignAllBottom, metrics: nil, views: ["imageView": imageView])
        self.addConstraints(constraintsH + constraintsV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
