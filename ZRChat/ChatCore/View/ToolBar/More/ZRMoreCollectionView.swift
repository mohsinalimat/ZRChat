//
//  ZRMoreCollectionView.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/19.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

protocol ZRMoreDelegate {
    
    // 被选中的index
    func moreSelectedAtIndex(_ index: Int)
}

class ZRMoreCollectionView: UICollectionView {

    var moreDelegate: ZRMoreDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellForTouches(_ touches: Set<UITouch>) -> Int? {
        let touch =  touches.first as UITouch!
        let point = touch?.location(in: self)
        let indexPath = self.indexPathForItem(at: point!)
        
        guard let _indexPath = indexPath else { return nil }
        let index = _indexPath.section * 8 + (_indexPath.row % 2) * 4 + (_indexPath.row / 2)
        return index
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let index = self.cellForTouches(touches) else { return }
        self.moreDelegate?.moreSelectedAtIndex(index)
    }
}
