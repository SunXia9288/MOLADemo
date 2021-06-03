//
//  GameSectionHeadView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/1.
//

import Foundation
import UIKit

class GameSectionHeadView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.textBlackColor
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.textGaryColor, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(rightButton)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        initModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initModel() {
        titleLabel.text = "热门社区"
        rightButton.setTitle("查看更多", for: .normal)
    }
    
}
