//
//  FollowButton.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class FollowButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setTitle("关注", for: .normal)
        setTitle("已关注", for: .selected)
        setTitleColor(UIColor.molaColor, for: .normal)
        setTitleColor(UIColor.white, for: .selected)
        addTarget(self, action: #selector(followClick(_:)), for: .touchUpInside)
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = 4
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func followClick(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            backgroundColor = UIColor.white
        } else {
            sender.isSelected = true
            backgroundColor = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
        }
    }
}
