//
//  ZRToolBar+Layout.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/22.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

extension ZRToolBar {

    override open func draw(_ rect: CGRect) {
        self.layout()
    }
    
    fileprivate func layout() {
        guard let superView = self.superview else { return }
        
        superView.addSubview(emotionView)
        let motionH = "H:|-0-[emotionView]-0-|"
        let motionV = "V:[emotionView(\(ZRMoreView.defaultH))]"
        let motionConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: motionH, options: .alignAllBottom, metrics: nil, views: ["emotionView": emotionView])
        let motionConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: motionV, options: .alignAllCenterX, metrics: nil, views: ["emotionView": emotionView])
        superView.addConstraints(motionConstraintsV + motionConstraintsH)
        
        emotionVariableV = NSLayoutConstraint(item: emotionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        superView.addConstraint(emotionVariableV)
        
        //  加载more view
        superView.addSubview(moreView)
        let moreH = "H:|-0-[moreView]-0-|"
        let moreV = "V:[moreView(\(ZRMoreView.defaultH))]"
        let moreConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: moreH, options: .alignAllBottom, metrics: nil, views: ["moreView": moreView])
        let moreConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: moreV, options: .alignAllCenterX, metrics: nil, views: [ "moreView": moreView])
        superView.addConstraints(moreConstraintsV + moreConstraintsH)
        
        moreVariableV = NSLayoutConstraint(item: moreView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        superView.addConstraint(moreVariableV)
        
        // 加载录音的提示界面
        superView.addSubview(recordIndicator)
        let width = superView.bounds.width
        let height = superView.bounds.height
        recordIndicator.frame = CGRect(x: (width - 150) / 2, y: (height - 150) / 2 - 50, width: 150, height: 150)
    }
}
