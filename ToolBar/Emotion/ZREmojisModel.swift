//
//  ZREmojisModel.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/18.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

public enum EmojiType {
    case normal  // mornal emoji
    case delete // delete button
}

open class ZREmojisModel {
    
    // image name
    var imageName: String
    
    // text
    var text: String
    
    // type
    var type: EmojiType
    
    init(imageName: String, text: String, type: EmojiType) {
        self.imageName = imageName
        self.text = text
        self.type = type
    }
}
