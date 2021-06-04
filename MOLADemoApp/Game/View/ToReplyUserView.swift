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
        initModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(replyContentLabel)
        replyContentLabel.backgroundColor = UIColor.textGaryColor
        replyContentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func initModel() {
        let atterstring = NSMutableAttributedString(string: "这是一段可点击的文字，点击百度去浏览网页吧")
        let nsString = NSString(string: atterstring.string)
        let nsRange = nsString.range(of: "百度")
        atterstring.addAttribute(NSAttributedString.Key.link, value: "https://www.baidu.com", range: nsRange)
        
        atterstring.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: atterstring.length))
        
        replyContentLabel.attributedText = atterstring
        replyContentLabel.linkTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.underlineColor: UIColor.molaColor]
        
    }
}


extension ToReplyUserView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("22314124214")
        return false
    }
}
