//
//  ZRChatViewController+Keyboard.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/16.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

extension ZRChatViewController {
    
    // MARK: - 监测键盘通知
    func notifyKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keybordShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc fileprivate func keybordShow(notification:Notification){
//        guard self.toolBar.keyboardType == .text else { return }
        guard let userInfo = notification.userInfo else { return }
        guard let frame = userInfo[UIKeyboardFrameEndUserInfoKey] else { return }
        let boardH = (frame as! CGRect).size.height
        UIView.animate(withDuration: 0.25, animations: {
            self.toolBarVariableV.constant = -boardH
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - Controller添加点击事件
    func useKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.chatListTableView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.25, animations: {
            self.toolBarVariableV.constant = 0
            self.toolBar.resetWhenTaped()
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - ToolBar Delegate
    
    func keyboardHeight(height: CGFloat) {
        self.toolBarVariableV.constant = -height
    }
    
    func textViewHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.toolBarHeight.constant = height + 10
            self.view.layoutIfNeeded()
        })
    }
}
