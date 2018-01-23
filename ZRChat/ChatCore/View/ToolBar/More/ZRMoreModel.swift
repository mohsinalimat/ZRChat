//
//  ZRMoreModel.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/19.
//  Copyright © 2018年 Zero. All rights reserved.
//

import Foundation

open class ZRMoreModel {
    
    /*
     @description image's name
     */
    var imageStr: String
    
    /*
     @description title
     */
    var title: String
    
    public init(imageStr: String, title: String) {
        self.imageStr = imageStr
        self.title = title
    }
}
