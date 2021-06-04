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
        return label
    }()
    
    private lazy var bottomView: OperationBottomView = {
        let view = OperationBottomView()
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        initModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(userTopView)
        contentView.addSubview(toReplyUserView)
        userTopView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        toReplyUserView.snp.makeConstraints { make in
            make.top.equalTo(userTopView.snp.bottom)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    func initModel() {
        
    }
}
