//
//  GameReplyCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/3.
//

import UIKit

class GameReplyCell: UITableViewCell {
    
    private lazy var userTopView: UserTopView = {
        let view = UserTopView()
        return view
    }()
    
    private lazy var toReplyUserView: ToReplyUserView = {
        let view = ToReplyUserView()
        return view
    }()
    
    private lazy var replyContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.textBlackColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bottomView: OperationBottomView = {
        let view = OperationBottomView()
        return view
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.bgGaryColor
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
        contentView.addSubview(userTopView)
        contentView.addSubview(toReplyUserView)
        contentView.addSubview(replyContentLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(bottomLine)
        
        userTopView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        toReplyUserView.snp.makeConstraints { make in
            make.top.equalTo(userTopView.snp.bottom)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-10)
           
        }
        
        replyContentLabel.snp.makeConstraints { make in
            make.top.equalTo(toReplyUserView.snp.bottom).offset(10)
            make.left.equalTo(toReplyUserView.snp.left)
            make.right.equalTo(toReplyUserView.snp.right)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(replyContentLabel.snp.bottom).offset(10)
            make.left.equalTo(toReplyUserView.snp.left)
            make.right.equalTo(toReplyUserView.snp.right)
            make.height.equalTo(40)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.bottom).offset(5)
            make.left.equalTo(toReplyUserView.snp.left)
            make.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func setModel() {
        replyContentLabel.text = "至少在我看来江湖不是打打杀杀，详情参考武林外传。至少我认为的江湖应该是有感情的，有烟火气的，有留恋的和自己所爱的。这才是江湖。没参加内测，但是从看到这款游戏开始就一直在等待，我希望它能还原给我一个我心目中的一个江湖。是的，江湖悠悠做到了，至少在我心目中是做到了。"
    }
}
