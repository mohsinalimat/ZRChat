//
//  ZRButton.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/15.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

// 工具栏Button
class ZRToolBarButton: UIButton {
    // 是否被点击
    var typed = false {
        didSet {
            if typed {
                self.setImage(typeImg, for: UIControlState())
            } else {
                self.setImage(normalImg, for: UIControlState())
            }
        }
    }
    
    // 点击后的图片
    fileprivate var typeImg: UIImage?
    // 正常模式的图片
    fileprivate var normalImg: UIImage?
    
    convenience init(typeImg: UIImage?, normalImg: UIImage?) {
        self.init(type: .custom)
        
        self.typeImg = typeImg
        self.normalImg = normalImg
        self.setImage(normalImg, for: UIControlState())
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

