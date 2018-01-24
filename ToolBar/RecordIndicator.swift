//
//  RecordIndicator.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/17.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

class RecordIndicator: UIView {

    var volume = 1 {
        didSet {
            volumeImg.image = UIImage(named:"zr_signal0" + String(describing: volume))
        }
    }
    
    var status = VoiceStatus.start {
        didSet {
            self.superview?.bringSubview(toFront: self)
            switch status {
            case .start:
                self.isHidden = false
                self.recordImg.isHidden = false
                self.volumeImg.isHidden = false
                volumeImg.image = UIImage(named:"zr_signal01")
                self.cancelImg.isHidden = true
                self.tipLabel.text = NSLocalizedString("手指上滑, 取消录音", comment: "ZRCHARTBAR")
                self.tipLabel.backgroundColor = UIColor.clear
            case .cancel:
                self.isHidden = false
                self.recordImg.isHidden = true
                self.volumeImg.isHidden = true
                volumeImg.image = UIImage(named:"zr_signal01")
                self.cancelImg.isHidden = false
                self.tipLabel.text = NSLocalizedString("松开手指, 取消发送", comment: "ZRCHARTBAR")
                self.tipLabel.backgroundColor = UIColor.red
            case .end:
                self.isHidden = true
            }
        }
    }
    
    fileprivate lazy var cancelImg = UIImageView(image: UIImage(named: "zr_record_cancel"))
    fileprivate lazy var recordImg = UIImageView(image: UIImage(named: "zr_recording"))
    fileprivate lazy var volumeImg = UIImageView(image: UIImage(named: "zr_signal01"))
    fileprivate lazy var tipLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 2
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.addSubview(cancelImg)
        self.addSubview(recordImg)
        self.addSubview(volumeImg)
        self.addSubview(tipLabel)
        
        cancelImg.frame = CGRect(x: 25, y: 25, width: 100, height: 100)
        recordImg.frame = CGRect(x: 25, y: 25, width: 62, height: 100)
        volumeImg.frame = CGRect(x: 87, y: 25, width: 38, height: 100)
        tipLabel.frame = CGRect(x: 10, y: 122, width: 130, height: 20)
        
        self.isHidden = true
    }
}
