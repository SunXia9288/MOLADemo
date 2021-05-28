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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let imagv = UIImageView()
        imagv.contentMode = .scaleAspectFill
        imagv.clipsToBounds = true
        imagv.layer.cornerRadius = 8
        return imagv
    }()
    
    private lazy var segmentationLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.segmentationColor
        return view
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
    
    private func initUI() {
        contentView.addSubview(userTopView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imgView)
        contentView.addSubview(segmentationLine)
        contentView.addSubview(bottomView)
        
        userTopView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(userTopView.snp.bottom).offset(10)
        }
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        bottomView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        segmentationLine.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(bottomView.snp.bottom).offset(10)
            make.height.equalTo(6)
        }
        

    }
    
    private func initModel() {
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        imgView.kf.setImage(with: url)
        
        titleLabel.text = "我们曾向各位冒险者宣传“上线领200抽”。而实际上，这200抽是需要大家通过升级才能陆续获得，总共需要升级到90级才能完整获取完毕。也因此，让大家产生了误解。 对此，我们感到非常抱歉，对于这种“骗我入坑”的感受，我们也是当过玩家，非常能理解大家的心情。这次的误解，本质来说是我们的经验不足，以为这种说法是大家能接受的，没想到会引来如此多的差评。目前，我们已经全面取消删除。"
    }
    
}
