//
//  ZRToolBarDelegate.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/22.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

public protocol ZRToolBarDataSource {
    // more模块的内容
    func contentForMore() -> [ZRMoreModel]
    
    // emoji模块的表情包
    func contentForEmojis() -> [ZREmojisModel]
}

public protocol ZRToolBarDelegate {
    
    // keyboard高度变化
    func keyboardHeight(height: CGFloat)
    
    // textView高度变换
    func textViewHeight(_ height: CGFloat)
    
    // 发送文字
    func sendText(text: String)
    
    // 发送语音
    func voiceStatus(status: VoiceStatus)

    /*
     index selected in more module
     @param index   selected index
     */
    func moreDidSelectedAtIndex(index: Int)
}
