//
//  NewGameBannerCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

// banner+ 游戏信息
import UIKit

class NewGameBannerCell: UITableViewCell {
    
    private lazy var banner: UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textBlackColor
        return label
    }()
    
    private lazy var tagButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.randomColor, for: .normal)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(banner)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagButton)
        contentView.addSubview(descriptionLabel)
        
        banner.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(175)
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(banner)
            make.left.equalTo(banner.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        
        tagButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagButton.snp.bottom)
            make.left.right.equalTo(titleLabel)
        }
    }
    
    func setModel() {
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        banner.kf.setImage(with: url)
        
        titleLabel.text = "天地劫 江湖再见"
        tagButton.setTitle("首发", for: .normal)
        descriptionLabel.text = "对战型卡牌TCG，10大英灵娘，575种卡牌库，开起卡牌对战。"
        
    }
}
