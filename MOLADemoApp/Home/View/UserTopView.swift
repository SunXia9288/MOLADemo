//
//  UserTopView.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class UserTopView: UIView {
    
    private lazy var userAvatarsImageV: UIImageView = {
        let imagV = UIImageView()
        imagV.contentMode = .scaleAspectFill
        return imagV
    }()
    
    private lazy var userNickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.textBlackColor
        return label
    }()
    
    private lazy var userCreateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    private lazy var settingButton: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initFrame()
        initModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        addSubview(userAvatarsImageV)
        addSubview(userNickNameLabel)
        addSubview(userCreateTimeLabel)
        addSubview(settingButton)
    }
    
    private func initFrame() {
        userAvatarsImageV.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        userNickNameLabel.snp.makeConstraints { make in
            make.left.equalTo(userAvatarsImageV.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(settingButton.snp.left)
        }
        
        userCreateTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(userNickNameLabel)
            make.top.equalTo(userNickNameLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func initModel() {
        userAvatarsImageV.backgroundColor = UIColor.red
        userAvatarsImageV.clipsToBounds = true
        userAvatarsImageV.layer.cornerRadius = 25
        
        userNickNameLabel.text = "肤白貌美大长腿，人见人爱可爱花,肤白貌美大长腿，人见人爱可爱花"
        userCreateTimeLabel.text = "05-13"
        settingButton.backgroundColor = UIColor.green
    }
}
