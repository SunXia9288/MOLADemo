//
//  DynamicCell.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class DynamicCell: UITableViewCell {
    
    private lazy var userTopView: UserTopView = {
        let view = UserTopView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        contentView.addSubview(userTopView)
        
        userTopView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
}
