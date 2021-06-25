//
//  CommentEditViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/7.
//

import Foundation
import UIKit

class CommentEditViewController: BaseViewController {
    private lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        label.numberOfLines = 0
        return label
    }()

    private lazy var replyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.textBlackColor
        return textView
    }()

    private lazy var imagesView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "评论界面"
        let item = UIBarButtonItem(title: "发布", style: UIBarButtonItem.Style.plain, target: self, action: #selector(navRightClick))
        navigationItem.rightBarButtonItem = item

        initUI()
        setModel()

        replyTextView.becomeFirstResponder()
    }

    func initUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(replyLabel)
        view.addSubview(replyTextView)
        view.addSubview(imagesView)

        replyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }

        replyTextView.snp.makeConstraints { make in
            make.top.equalTo(replyLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(400)
        }

        imagesView.snp.makeConstraints { make in
            make.top.equalTo(replyTextView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func setModel() {
        replyLabel.text = "这里显示的内容是被回复者的内容，如果直接回复楼主，这里则不会显示。"
        replyTextView.text = "说点什么吧"
    }

    @objc func navRightClick() {
        SVProgressHUD.showSuccess(withStatus: "发布成功")
        navigationController?.popViewController(animated: true)
    }
}
