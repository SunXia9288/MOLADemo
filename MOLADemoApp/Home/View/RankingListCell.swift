//
//  RankingListCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import UIKit

class RankingListCell: UITableViewCell {

    private lazy var icon: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.clipsToBounds = true
        return imgv
    }()
    
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textBlackColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
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
    
    private lazy var downloadButton: DownloadButton = {
        let button = DownloadButton(type: .custom)
        return button
    }()
    
    public var type: String?
    
    public var model: GameModel? {
        didSet{
            setModel()
            downloadButton.model = model?.uri
        }
    }
    
    public var row: Int = 0 {
        didSet{
            let number = NSNumber.init(value: row)
            numLabel.text = number.stringValue
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle  , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        setModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(icon)
        contentView.addSubview(numLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(hotLabel)
        contentView.addSubview(onLineTimeLabel)
        contentView.addSubview(downloadButton)
        
        numLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }

        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(numLabel.snp.right).offset(15)
            make.width.height.equalTo(70)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.right.lessThanOrEqualTo(downloadButton.snp.left).offset(-5)
            make.top.equalTo(icon)
            make.height.equalTo(20)
        }
        
        hotLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        hotLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.lessThanOrEqualTo(downloadButton.snp.left).offset(-5)
            make.height.equalTo(20)
        }
        
        onLineTimeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        onLineTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.right.lessThanOrEqualTo(downloadButton.snp.left).offset(-5)
            make.top.equalTo(hotLabel.snp.bottom).offset(4)
            make.height.equalTo(20)
        }
        
        downloadButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(icon)
        }

    }
    
    func setModel() {
        if let model = model {
            let url = URL(string: (model.icon?.url ?? ""))
            icon.kf.setImage(with: url)
           
            titleLabel.text = model.title
           
            if type == "reserve" {
                let pvCount = NSNumber.init(value: (model.stat?.pv_count ?? 0))
                hotLabel.text = "\(pvCount.stringValue) 热度"
            }else{
                let downloadCount = NSNumber.init(value: (model.stat?.download_count ?? 0))
                hotLabel.text = "\(downloadCount.stringValue) 下载"
            }
            
            if let array = model.tags?.map({ (stu) in
                return stu.value
            }) , array.count > 0{
                onLineTimeLabel.text = array.joined(separator: " ")
            }else{
                onLineTimeLabel.text = model.author
            }
        }
    }
}

