//
//  PublishBottomView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/7.
//

import UIKit

protocol PublishBottomViewProtocol {
    func publicClick()
}

class PublishBottomView: UIView {
    var delegate: PublishBottomViewProtocol?

    private lazy var publishLabel: BaseLabel2 = {
        let label = BaseLabel2()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.textBlackColor
        label.isUserInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(labelClick))
        label.addGestureRecognizer(ges)
        label.layer.cornerRadius = 15.0
        label.clipsToBounds = true
        label.backgroundColor = UIColor.bgGaryColor
        return label
    }()

    private lazy var commentButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.textBlackColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()

    private lazy var upButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.textBlackColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()

    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.textBlackColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(publishLabel)
        addSubview(commentButton)
        addSubview(upButton)
        addSubview(shareButton)

        publishLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(commentButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }

        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }

        upButton.snp.makeConstraints { make in
            make.right.equalTo(shareButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }

        commentButton.snp.makeConstraints { make in
            make.right.equalTo(upButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }

        setModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setModel() {
        publishLabel.text = "说点什么吧。。。"
        shareButton.setTitle("分享", for: .normal)
        upButton.setTitle("点赞", for: .normal)
        commentButton.setTitle("评论", for: .normal)
    }

    @objc func labelClick() {
        print("publishLabel -- click")
        delegate?.publicClick()
    }
}
