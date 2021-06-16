//
//  NewGameTitleCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//


//小banner + 游戏信息
import UIKit


class NewGameTopView: UIView {
    
    private lazy var tipButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.molaColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(tipButton)
        addSubview(timeLabel)
        
        tipButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(tipButton.snp.right).offset(10)
            make.centerY.equalTo(tipButton)
        }
    }
    
    func setModel() {
        tipButton.setTitle("首发", for: .normal)
        timeLabel.text = "11:00"
    }
}

class NewGameBottomView: UIView {
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.textBlackColor
        return label
    }()
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    private lazy var followButton: FollowButton = {
        let button = FollowButton(type: .custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        addSubview(gameLabel)
        addSubview(introLabel)
        addSubview(followButton)
        gameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        introLabel.snp.makeConstraints { make in
            make.left.equalTo(gameLabel)
            make.top.equalTo(gameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        followButton.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(28)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    func setModel() {
        gameLabel.text = "崩坏3"
        introLabel.text = "[崩坏3 x 原神] 联动开启"
    }
}


class NewGameTitleCell: UITableViewCell {
    
    private lazy var newGameTopView: NewGameTopView = {
        let view = NewGameTopView()
        return view
    }()
    
    private lazy var imgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var newGameBottomView: NewGameBottomView = {
        let view = NewGameBottomView()
        return view
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
        contentView.addSubview(newGameTopView)
        contentView.addSubview(imgV)
        contentView.addSubview(newGameBottomView)
        
        newGameTopView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
        }
        
        imgV.snp.makeConstraints { make in
            make.top.equalTo(newGameTopView.snp.bottom)
            make.left.right.equalTo(newGameTopView)
            make.height.equalTo(135)
        }
        
        newGameBottomView.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(10)
            make.left.right.equalTo(newGameTopView)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setModel() {
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        imgV.kf.setImage(with: url)
    }
    
}
