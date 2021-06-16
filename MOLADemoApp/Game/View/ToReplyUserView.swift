//
//  ToReplyUserView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/3.
//

import UIKit

class ToReplyUserView: UIView {
    
    private lazy var replyContentLabel: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(replyContentLabel)
        replyContentLabel.backgroundColor = UIColor.bgGaryColor
        replyContentLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setModel() {
        let nickName = "我是个小白用户:"
        let contStr = "这个游戏我比较喜欢，但是你说的这些，太过激进，可以稍微给他们一些颜面。"
        let atterstring = NSMutableAttributedString(string: nickName + contStr)
        let nsString = NSString(string: atterstring.string)
        let nsRange = nsString.range(of: nickName)
        atterstring.addAttribute(NSAttributedString.Key.link, value: "http://baidu.com", range: nsRange)
        
        atterstring.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13), range: NSRange.init(location: 0, length: atterstring.length))
        
        replyContentLabel.attributedText = atterstring
        replyContentLabel.textColor = UIColor.textGaryColor
        replyContentLabel.linkTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.molaColor]
        
    }
}


extension ToReplyUserView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("22314124214")
        return false
    }
}
