//
//  GameInfoView.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class GameInfoView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var downloadButton: DownloadButton = {
        let button = DownloadButton(type: .custom)
        return button
    }()
    
    private lazy var numbersTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var NewsInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    public var model: GameModel? {
        didSet{
            setModel()
            downloadButton.model = model?.uri
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
        addSubview(titleLabel)
        addSubview(downloadButton)
        addSubview(numbersTitleLabel)
//        addSubview(NewsInfoView)
    }
    
    private func initFrame() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLabel)
        }
        
        numbersTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    private func setModel() {
        if let model = model {
            titleLabel.text = model.title
    //        numbersTitleLabel.text = "488万关注 - 68万动态"
            if let fans_count = model.stat?.fans_count, fans_count > -1{
                let followNum = NSNumber.init(value: fans_count)
                let feedNum = NSNumber.init(value: model.stat?.feed_count ?? 0)
                numbersTitleLabel.text = "\(followNum)关注 - \(feedNum)动态"
            }
        
        }
    }
}
