//
//  ZRToolBar+Keyboard.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/22.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

extension ZRToolBar {
    
    internal func setKeyboardType(type: ZRKeyBoardType) {
        switch type {
        case .default:
            self.textView.resignFirstResponder()
            voiceButton.typed = false
            emotionButton.typed = false
            moreButton.typed = false
        case .emotion:
            voiceButton.typed = false
            moreButton.typed = false
            emotionButton.typed = !emotionButton.typed
            if emotionButton.typed {
                self.reLayout(type: .emotion)
                self.recordButton.isHidden = true
                self.textView.resignFirstResponder()
            } else {
                self.textView.becomeFirstResponder()
            }
        case .more:
            voiceButton.typed = false
            emotionButton.typed = false
            moreButton.typed = !moreButton.typed
            if moreButton.typed {
                self.reLayout(type: .more)
                self.recordButton.isHidden = true
                self.textView.resignFirstResponder()
            } else {
                self.textView.becomeFirstResponder()
            }
        case .text:
            voiceButton.typed = false
            emotionButton.typed = false
            moreButton.typed = false
        case .voice:
            voiceButton.typed = !voiceButton.typed
            emotionButton.typed = false
            moreButton.typed = false
            if voiceButton.typed {
                self.reLayout(type: .voice)
                self.recordButton.isHidden = false
                self.textView.resignFirstResponder()
            } else {
                self.recordButton.isHidden = true
                self.textView.becomeFirstResponder()
            }
        }
    }
    
    func reLayout(type: ZRKeyBoardType) {
        switch type {
        case .default, .voice:
            UIView.animate(withDuration: 0.25, animations: {
                self.delegate?.keyboardHeight(height: 0)
                self.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
            })
        case .emotion:
            UIView.animate(withDuration: 0.25, animations: {
                self.delegate?.keyboardHeight(height: ZREmotionView.defaultH)
                self.emotionVariableV.constant = 0
                self.moreVariableV.constant = ZRMoreView.defaultH
                self.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
            })
        case .more:
            UIView.animate(withDuration: 0.25, animations: {
                self.delegate?.keyboardHeight(height: ZREmotionView.defaultH)
                self.emotionVariableV.constant = ZREmotionView.defaultH
                self.moreVariableV.constant = 0
                self.layoutIfNeeded()
                self.superview?.layoutIfNeeded()
            })
        default:
            break
        }
    }
}
