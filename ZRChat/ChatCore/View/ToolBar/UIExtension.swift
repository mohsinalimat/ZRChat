//
//  UIExtension.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/16.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

extension UIColor {
    
    var image: UIImage? {
        get {
            let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(self.cgColor)
            context?.fill(rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
    }
    
    public convenience init(_ value: Int) {
        let r = CGFloat(value >> 16 & 0xFF) / 255.0
        let g = CGFloat(value >> 8 & 0xFF) / 255.0
        let b = CGFloat(value & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
