//
//  GameInfoView.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class GameInfoView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var followButton: FollowButton = {
        let button = FollowButton(type: .custom)
        return button
    }()
    
    private lazy var numbersTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var NewsInfoView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initFrame()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        addSubview(titleLabel)
        addSubview(followButton)
        addSubview(numbersTitleLabel)
        addSubview(NewsInfoView)
    }
    
    private func initFrame() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        followButton.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(28)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLabel)
        }
        
        numbersTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    private func setModel() {
        titleLabel.text = "明日方舟"
        numbersTitleLabel.text = "488万关注 - 68万动态"
    }
}
