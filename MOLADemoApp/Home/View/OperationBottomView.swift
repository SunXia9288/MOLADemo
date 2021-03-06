//
//  OperationBottomView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/27.
//

import UIKit

class OperationBottomView: UIView {
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.downloadTitleColor
        return label
    }()

    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var upButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()

    private lazy var replyButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()

    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()

    public var model: GameModel? {
        didSet {
            setModel()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initFrame()
        setModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initUI() {
        addSubview(leftLabel)
        addSubview(rightView)
        rightView.addSubview(upButton)
        rightView.addSubview(replyButton)
        rightView.addSubview(shareButton)

        shareButton.setTitle("分享", for: .normal)
        replyButton.setTitle("回复", for: .normal)
        upButton.setTitle("点赞", for: .normal)
    }

    private func initFrame() {
        leftLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(rightView.snp.left)
            make.height.equalTo(20)
        }

        rightView.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
            make.height.equalTo(30)
        }

        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }

        replyButton.snp.makeConstraints { make in
            make.right.equalTo(shareButton.snp.left).offset(-5)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }

        upButton.snp.makeConstraints { make in
            make.right.equalTo(replyButton.snp.left).offset(-5)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.left.equalToSuperview()
        }
    }

    func setModel() {
        if let model = model {
            leftLabel.text = model.category
        }
    }
}
