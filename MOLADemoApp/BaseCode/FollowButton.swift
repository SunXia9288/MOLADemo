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
        self.backgroundColor = UIColor.white
        self.setTitle("关注", for: .normal)
        self.setTitle("已关注", for: .selected)
        self.setTitleColor(UIColor.molaColor, for: .normal)
        self.setTitleColor(UIColor.white, for: .selected)
        self.addTarget(self, action: #selector(followClick(_:)), for: .touchUpInside)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func followClick(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.backgroundColor = UIColor.white
        }else{
            sender.isSelected = true
            self.backgroundColor = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
        }
    }
    
}
