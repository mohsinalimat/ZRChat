//
//  ZRToolBar+Record.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/22.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

public enum VoiceStatus {
    /*
     开始录音
     */
    case start
    
    /*
     结束录音
     */
    case end
    
    /*
     取消录音
     */
    case cancel
}

extension ZRToolBar {

    // 1 ~ 8
    open func setVolume(volume: Int) {
        self.recordIndicator.volume = volume
    }
    
    func recordControl() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(recordTap))
        self.recordButton.addGestureRecognizer(longTap)
    }
    
    // 判断是否应该发送语音
    @objc fileprivate func recordTap(ges: UILongPressGestureRecognizer) {
        switch ges.state {
        case .began:
            self.delegate?.voiceStatus(status: .start)
            self.recordButton.isHighlighted = true
            self.recordIndicator.status = .start
        case .changed:
            let point = ges.location(in: self)
            if self.point(inside: point, with: nil) {
                self.recordIndicator.status = .start
                self.shouldRecord = true
            } else {
                self.recordIndicator.status = .cancel
                self.shouldRecord = false
            }
            self.recordButton.isHighlighted = true
        case .ended:
            self.recordButton.isHighlighted = false
            self.recordIndicator.status = .end
            if shouldRecord { // 处理录音
                self.delegate?.voiceStatus(status: .end)
            } else { // 取消录音
                self.delegate?.voiceStatus(status: .cancel)
            }
        default:
            self.delegate?.voiceStatus(status: .cancel)
            self.recordButton.isHighlighted = true
        }
    }
}
