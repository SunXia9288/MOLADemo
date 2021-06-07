//
//  GameCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/28.
//

import UIKit

class GameCell: CornerBaseCell {
    
    private lazy var iconImgV: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.clipsToBounds = true
        imgv.layer.cornerRadius = 4.0
        return imgv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.textBlackColor
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var contLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        initUI()
        initModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(iconImgV)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contLabel)
        
        iconImgV.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(0.28*KScreenWidth)
            make.height.equalTo(0.28*KScreenWidth*0.5)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImgV.snp.right).offset(10)
            make.top.equalTo(iconImgV).offset(3)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(25)
        }
        
        contLabel.snp.makeConstraints { make in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.height.equalTo(20)
        }
        
    }
    private func initModel() {
        
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        iconImgV.kf.setImage(with: url)
        titleLabel.text = "发现好游戏"
        contLabel.text = "25新帖-六月新游预告: 《格尔莫斯》"
    }
}
