//
//  ZRChatViewController+Layout.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/16.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

extension ZRChatViewController {
    
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
}
