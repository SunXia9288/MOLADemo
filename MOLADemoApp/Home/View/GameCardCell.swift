//
//  GameCardCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/21.
//

import UIKit

class GameCardCell: UITableViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var banner: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.bgGaryColor
        initUI()
        setConstraints()
        setModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(banner)
    }

    func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(16)
            make.right.equalTo(self.contentView).offset(-16)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
        
        banner.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(bgView)
            make.height.equalTo((KScreenWidth - 16.0*2)*0.56)
        }
    }
    
    func setModel() {
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        banner.kf.setImage(with: url)
    }
    
}
