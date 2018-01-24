//
//  ZRToolBar.swift
//  ZRChat
//
//  Created by 李锋 on 2018/1/15.
//  Copyright © 2018年 Zero. All rights reserved.
//

import UIKit

open class ZRToolBar: UIView, UITextViewDelegate, ZRMoreDelegate, ZREmotionDelegate {

    // emotion 可变约束
    lazy var emotionVariableV: NSLayoutConstraint = NSLayoutConstraint()
    // more 可变约束
    lazy var moreVariableV: NSLayoutConstraint = NSLayoutConstraint()
    
    lazy var shouldRecord = false
    
    lazy var emotionView: ZREmotionView = {
        var view = ZREmotionView()
        view.collectionView.emotionDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moreView: ZRMoreView = {
        var view = ZRMoreView()
        view.collectionView.moreDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var recordIndicator: RecordIndicator = {
        var view = RecordIndicator()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 默认高度
    static let toolBarDefaultHeight: CGFloat = 50
    
    // 代理
    open var delegate: ZRToolBarDelegate?
    open var datasource: ZRToolBarDataSource?
    
    // 当点击controller时,重置所有的按钮状态
    open func resetWhenTaped() {
        moreButton.typed = false
        emotionButton.typed = false
    }
    
    lazy var textView: UITextView = {
        var textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor(0xDADADA).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5.0
        textView.backgroundColor = UIColor(0xF8FEFB)
        textView.returnKeyType = .send
        textView.enablesReturnKeyAutomatically = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        return textView
    }()
    
    lazy var voiceButton = ZRToolBarButton(typeImg: UIImage(named: "zr_keyboard"), normalImg: UIImage(named: "zr_voice"))
    lazy var emotionButton = ZRToolBarButton(typeImg: UIImage(named: "zr_keyboard"), normalImg: UIImage(named: "zr_emotion"))
    lazy var moreButton = ZRToolBarButton(typeImg: UIImage(named: "zr_keyboard"), normalImg: UIImage(named: "zr_more"))
    
    lazy var recordButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("按住 说话", comment: "ZRCHARTBAR"), for: .normal)
        button.setTitleColor(UIColor.darkGray, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setBackgroundImage(UIColor(0xF3F4F8).image, for: .normal)
        button.setBackgroundImage(UIColor(0xC6C7CB).image, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(0xC2C3C7).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        button.isHidden = true
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
        self.recordControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(0xEFF0F5)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(voiceButton)
        self.addSubview(textView)
        self.addSubview(recordButton)
        self.addSubview(emotionButton)
        self.addSubview(moreButton)
        let h = "H:|-5-[voiceButton(35)]-5-[textView]-5-[emotionButton(35)]-0-[moreButton(35)]-5-|"
        let v = "V:|-5-[textView]-5-|"
        let textViewConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: h, options: .alignAllBottom, metrics: nil, views: ["voiceButton": voiceButton, "textView": textView, "emotionButton": emotionButton, "moreButton": moreButton])
        let textViewConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: v, options: .alignAllBottom, metrics: nil, views: ["textView": textView])
        self.addConstraints(textViewConstraintsV + textViewConstraintsH)
        
        let recordH = "H:[voiceButton]-5-[recordButton]-5-[emotionButton]"
        let recordV = "V:|-5-[recordButton]-5-|"
        let recordConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: recordH, options: .alignAllBottom, metrics: nil, views: ["recordButton": recordButton, "voiceButton": voiceButton, "emotionButton": emotionButton])
        let recordConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: recordV, options: .alignAllBottom, metrics: nil, views: ["recordButton": recordButton])
        self.addConstraints(recordConstraintsV + recordConstraintsH)
        
        voiceButton.addTarget(self, action: #selector(voiceAction), for: .touchUpInside)
        emotionButton.addTarget(self, action: #selector(emotionAction), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        
        // 画边线
        let topBorder = UIView()
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        topBorder.backgroundColor = UIColor(0xC2C3C7)
        bottomBorder.backgroundColor = UIColor(0xC2C3C7)
        self.addSubview(topBorder)
        self.addSubview(bottomBorder)
        
        let topH = "H:|-0-[topBorder]-0-|"
        let topV = "V:|-0-[topBorder(0.5)]"
        let topConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: topH, options: .alignAllTop, metrics: nil, views: ["topBorder": topBorder])
        let topConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: topV, options: .alignAllTop, metrics: nil, views: ["topBorder": topBorder])
        self.addConstraints(topConstraintsH + topConstraintsV)
        
        let bottomH = "H:|-0-[bottomBorder]-0-|"
        let bottomV = "V:[bottomBorder(0.5)]-0-|"
        let bottomConstraintsH = NSLayoutConstraint.constraints(withVisualFormat: bottomH, options: .alignAllTop, metrics: nil, views: ["bottomBorder": bottomBorder])
        let bottomConstraintsV = NSLayoutConstraint.constraints(withVisualFormat: bottomV, options: .alignAllTop, metrics: nil, views: ["bottomBorder": bottomBorder])
        self.addConstraints(bottomConstraintsH + bottomConstraintsV)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    @objc fileprivate func voiceAction() {
        self.setKeyboardType(type: .voice)
    }
    
    fileprivate var emojisDataSource = [ZREmojisModel]()
    @objc fileprivate func emotionAction() {
        if emojisDataSource.count == 0 {
            if let dataSource = self.datasource?.contentForEmojis() {
                emojisDataSource = dataSource
            }
        }
        emotionView.dataSource = emojisDataSource
        emotionView.collectionView.reloadData()
        self.setKeyboardType(type: .emotion)
    }
    
    fileprivate var moreViewDataSource = [ZRMoreModel]()
    @objc fileprivate func moreAction() {
        if moreViewDataSource.count == 0 {
            if let dataSource = self.datasource?.contentForMore() {
                moreViewDataSource = dataSource
            }
        }
        moreView.dataSource = moreViewDataSource
        moreView.collectionView.reloadData()
        self.setKeyboardType(type: .more)
    }
    
    // MARK: - UITextView Delegate
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.setKeyboardType(type: .text)
        return true
    }
    
    fileprivate var lastHeight: CGFloat = 0
    public func textViewDidChange(_ textView: UITextView) {
        let height = textView.sizeThatFits(textView.frame.size).height
        guard height != lastHeight else { return }
        guard height <= 100 else { return }
        self.delegate?.textViewHeight(height)
        lastHeight = height
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.delegate?.sendText(text: textView.text)
            textView.text = ""
            return false
        }
        return true
    }
    
    // MARK: - MoreDelegate
    func moreSelectedAtIndex(_ index: Int) {
        guard index < moreViewDataSource.count else { return }
        self.delegate?.moreDidSelectedAtIndex(index: index)
    }
    
    // MARK: - Emojis Delegate
    func emotionSelected(_ text: String) {
        self.textView.insertText(text)
    }
    
    func emotionScrollViewDelete() {
        self.textView.deleteBackward()
    }
    
    func emotionScrollViewSend() {
        guard let text = self.textView.text else { return }
        self.delegate?.sendText(text: text)
        self.textView.text.removeAll()
        self.textViewDidChange(self.textView)
    }
}
