//
//  BaseTabBarItem.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit

class BaseTabBarItem: UIControl {
    var itemDic: [String: String]
    let imgView: UIImageView
    let titleLabel: UILabel

    // 属性观察器
    var currentSelectState = false {
        didSet {
            if currentSelectState {
                // 被选中
                imgView.image = UIImage(named: itemDic["SelectImg"]!)
                titleLabel.textColor = UIColor.molaColor
            } else {
                // 没被选中
                imgView.image = UIImage(named: itemDic["NormalImg"]!)
                titleLabel.textColor = UIColor.normalGaryColor
            }
        }
    }

    init(frame: CGRect, itemDic: [String: String], itemIndex _: Int) {
        self.itemDic = itemDic

        // 布局使用的参数
        let defaulutLabelH: CGFloat = 20.0 // 文字的高度
        let imgTop: CGFloat = 3
        let imgWidth: CGFloat = 25
        let imgLeft: CGFloat = (frame.size.width - imgWidth) / 2
        let imgHeight: CGFloat = frame.size.height - defaulutLabelH - imgTop
        // 图片
        imgView = UIImageView(frame: CGRect(x: imgLeft, y: imgTop, width: imgWidth, height: imgHeight))
        imgView.image = UIImage(named: itemDic["NormalImg"]!)
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        // title
        titleLabel = UILabel(frame: CGRect(x: 0, y: frame.height - defaulutLabelH, width: frame.size.width, height: defaulutLabelH))
        titleLabel.text = itemDic["Title"]!
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.normalGaryColor

        super.init(frame: frame)
        addSubview(imgView)
        addSubview(titleLabel)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
