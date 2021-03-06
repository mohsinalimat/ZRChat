//
//  ViewController.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/13.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ZRToolBarDelegate, ZRToolBarDataSource {

    lazy var chatListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.brown
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var toolBar: ZRToolBar = {
        var view = ZRToolBar()
        view.delegate = self
        view.datasource = self
        return view
    }()
    
    // toolBar 可变约束
    lazy var toolBarVariableV: NSLayoutConstraint = NSLayoutConstraint()
    // toolBar 高度
    lazy var toolBarHeight: NSLayoutConstraint = NSLayoutConstraint()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor(0xEFF0F5)
        // 布局UI
        self.layoutUI()
        // 监测键盘
        self.notifyKeyBoard()
        // 监听点击
        self.useKeyboardDismiss()
    }
    
    func layoutUI() {
        // 加载toolBar
        self.view.addSubview(toolBar)
        let toolBarH = "H:|-0-[toolBar]-0-|"
        let toolBarV = "V:[toolBar]"
        let toolBarConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: toolBarH, options: .alignAllBottom, metrics: nil, views: ["toolBar": toolBar])
        let toolBarConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: toolBarV, options: .alignAllBottom, metrics: nil, views: ["toolBar": toolBar])
        self.view.addConstraints(toolBarConstraintsV + toolBarConstraintsH)
        
        toolBarVariableV = NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        toolBarHeight = NSLayoutConstraint(item: toolBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        self.view.addConstraints([toolBarVariableV, toolBarHeight])
        
        // 加载table view
        self.view.addSubview(chatListTableView)
        let tableH = "H:|-0-[table]-0-|"
        let tableV = "V:|-0-[table]-0-[toolBar]"
        let tableConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: tableH, options: .alignAllBottom, metrics: nil, views: ["table": chatListTableView])
        let tableConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: tableV, options: .alignAllCenterX, metrics: nil, views: ["toolBar": toolBar, "table": chatListTableView])
        self.view.addConstraints(tableConstraintsV + tableConstraintsH)
    }
    
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
    
    // MARK: - ZRToolBar Delegate
    func keyboardHeight(height: CGFloat) {
        self.toolBarVariableV.constant = -height
    }
    
    func textViewHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.toolBarHeight.constant = height + 10
            self.view.layoutIfNeeded()
        })
    }
    
    func sendText(text: String) {
        print("【->:】", text)
    }
    
    func moreDidSelectedAtIndex(index: Int) {
        print("【more selected in:】 ", index)
    }
    
    func voiceStatus(status: VoiceStatus) {
        print(status)
    }
    
    // MARK: - ZRToolBar DataSource
    func contentForMore() -> [ZRMoreModel] {
        let model1 = ZRMoreModel(imageStr: "chatBar_colorMore_photo", title: "照片")
        let model2 = ZRMoreModel(imageStr: "chatBar_colorMore_camera", title: "相机")
        return [model1, model2]
    }
    
    func contentForEmojis() -> [ZREmojisModel] {
        let models = emojis.map { (title, imgStr) -> ZREmojisModel in
            return ZREmojisModel(imageName: imgStr, text: title, type: .normal)
        }
        return models
    }
}

