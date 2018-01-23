//
//  ZREmotionCollectionView.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/18.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

// 处理表情操作的相关

protocol ZREmotionDelegate {
    // 表情选中
    func emotionSelected(_ text: String)
    
    // 删除
    func emotionScrollViewDelete()
    
    // 发送
    func emotionScrollViewSend()
}

class ZREmotionCollectionView: UICollectionView {
    
    var emotionDelegate: ZREmotionDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellForTouches(_ touches: Set<UITouch>) -> ZREmojisCell? {
        let touch =  touches.first as UITouch!
        let point = touch?.location(in: self)
        let indexPath = self.indexPathForItem(at: point!)
        guard let newIndexPath = indexPath else {
            return nil
        }
        let cell = self.cellForItem(at: newIndexPath) as! ZREmojisCell
        return cell
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let cell = self.cellForTouches(touches) else { return }
        
        if cell.emojisModel.type == .delete {
            self.emotionDelegate?.emotionScrollViewDelete()
            return
        }
        
        if cell.emojisModel.imageName != "" {
            self.emotionDelegate?.emotionSelected(cell.emojisModel.text)
        }
    }
}
