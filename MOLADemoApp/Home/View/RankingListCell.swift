//
//  RankingListCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import UIKit

class RankingListCell: UITableViewCell {
    
    
    private lazy var rankNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imgv = UIImageView()
        imgv.backgroundColor = UIColor.blue
        imgv.contentMode = .scaleAspectFill
        imgv.clipsToBounds = true
        imgv.layer.cornerRadius = 8
        return imgv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textBlackColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var hotLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var onLineTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var followButton: FollowButton = {
        let button = FollowButton(type: .custom)
        button.backgroundColor = UIColor.molaColor
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle  , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        setModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(rankNumLabel)
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(hotLabel)
        contentView.addSubview(onLineTimeLabel)
        contentView.addSubview(followButton)
        
        rankNumLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(rankNumLabel.snp.right).offset(5)
            make.width.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.right.equalTo(followButton.snp.left).offset(-5)
            make.top.equalTo(icon)
            make.height.equalTo(20)
        }
        
        hotLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        
        onLineTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(hotLabel.snp.bottom).offset(4)
            make.height.equalTo(20)
      
        }
        
        followButton.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(35)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(icon)
        }
    }
    
    func setModel() {
        rankNumLabel.text = "1"
        
        titleLabel.text = "鬼泣-巅峰之战（送传说武器）"
        hotLabel.text = "22万下载 1.89G"
        onLineTimeLabel.text = "06月11日凌晨00:30正式上线06月11日凌晨00:30正式上线06月11日凌晨00:30正式上线"
    }
}

