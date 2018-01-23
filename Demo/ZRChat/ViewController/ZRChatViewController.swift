//
//  ZRChatViewController.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/15.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class ZRChatViewController: UIViewController, ZRToolBarDelegate, ZRToolBarDataSource {

    lazy var chatListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.brown
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.delegate = self
        return tableView
    }()
    
    lazy var toolBar: ZRToolBar = {
        var view = ZRToolBar()
        view.delegate = self
        view.datasource = self
        return view
    }()
    
    func contentForMore() -> [ZRMoreModel] {
        let model1 = ZRMoreModel(imageStr: "", title: "照片")
        let model2 = ZRMoreModel(imageStr: "", title: "医疗文件")
        let model3 = ZRMoreModel(imageStr: "", title: "位置")
        let model4 = ZRMoreModel(imageStr: "", title: "照片1")
        let model5 = ZRMoreModel(imageStr: "", title: "医疗文件2")
        let model6 = ZRMoreModel(imageStr: "", title: "位置3")
        let model7 = ZRMoreModel(imageStr: "", title: "照片4")
        let model8 = ZRMoreModel(imageStr: "", title: "医疗文件5")
        let model9 = ZRMoreModel(imageStr: "", title: "位置6")
        let model10 = ZRMoreModel(imageStr: "", title: "照片7")
        let model11 = ZRMoreModel(imageStr: "", title: "医疗文件8")
        let model12 = ZRMoreModel(imageStr: "", title: "位置9")
        return [model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12]
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
    
    func contentForEmojis() -> [ZREmojisModel] {
        let models = emojis.map { (title, imgStr) -> ZREmojisModel in
            return ZREmojisModel(imageName: imgStr, text: title, type: .normal)
        }
        return models
    }
    
    // toolBar 可变约束
    lazy var toolBarVariableV: NSLayoutConstraint = NSLayoutConstraint()
    // toolBar 高度
    lazy var toolBarHeight: NSLayoutConstraint = NSLayoutConstraint()
    
    // 控制录音是否应该取消/记录
    var shouldRecord = true
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
