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
        imagV.clipsToBounds = true
        imagV.layer.cornerRadius = 20
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
    
    public var model: GameFeedModel? {
        didSet{
            setModel()
        }
    }
    
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
        addSubview(userAvatarsImageV)
        addSubview(userNickNameLabel)
        addSubview(userCreateTimeLabel)
        addSubview(settingButton)
    }
    
    private func initFrame() {
        userAvatarsImageV.snp.makeConstraints { make in
            make.width.height.equalTo(40)
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
            make.top.equalTo(userNickNameLabel.snp.bottom)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setModel() {
        if let model = model {
            let url = URL(string: model.author?.avatar ?? "")
            userAvatarsImageV.kf.setImage(with: url)
            userNickNameLabel.text = model.author?.name
            let time = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(model.created_time), dateFormat: "HH-mm")
            userCreateTimeLabel.text = time
        }
    }
}
