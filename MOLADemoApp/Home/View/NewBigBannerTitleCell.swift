//
//  NewBigBannerTitleCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//


//小banner + 游戏信息
import UIKit


class NewGameTopView: UIView {
    
    private lazy var tipButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.lightRedAlphaColor
        btn.setTitleColor(UIColor.lightRedColor, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        return btn
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    public var model: NewGameModel? {
        didSet{
            setModel()
        }
    }
    
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
        if let model = model {
            tipButton.setTitle(model.type_label, for: .normal)
            timeLabel.text = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(model.event_at), dateFormat: " HH:mm")
            
            if model.type_label == "首发" {
                tipButton.backgroundColor = UIColor.lightRedAlphaColor
                tipButton.setTitleColor(UIColor.lightRedColor, for: .normal)
            }else{
                tipButton.backgroundColor = UIColor.downloadBGColor
                tipButton.setTitleColor(UIColor.downloadTitleColor, for: .normal)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tipButton.roundCorners(corners: [.topLeft, .topRight], radius: 4.0)
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
    
    private lazy var downloadButton: DownloadButton = {
        let button = DownloadButton(type: .custom)
        return button
    }()
    
    public var model: NewGameModel? {
        didSet{
            setModel()
            downloadButton.model = model?.app?.uri
        }
    }
    
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
        addSubview(downloadButton)
        gameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        gameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.lessThanOrEqualTo(downloadButton.snp.left).offset(-10)
        }
        
        introLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        introLabel.snp.makeConstraints { make in
            make.left.equalTo(gameLabel)
            make.top.equalTo(gameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.right.lessThanOrEqualTo(downloadButton.snp.left).offset(-10)
        }
        
        downloadButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        downloadButton.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setModel() {
        if let model = model {
            gameLabel.text = model.app?.title
            introLabel.text = model.rec_text
        }
    }
}


class NewBigBannerTitleCell: UITableViewCell {
    
    private lazy var newGameTopView: NewGameTopView = {
        let view = NewGameTopView()
        view.backgroundColor = UIColor.white
        return view 
    }()
    
    private lazy var imgV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        imgV.clipsToBounds = true
        return imgV
    }()
    
    private lazy var newGameBottomView: NewGameBottomView = {
        let view = NewGameBottomView()
        return view
    }()
    
    public var model: NewGameModel? {
        didSet{
            setModel()
            newGameTopView.model = model
            newGameBottomView.model = model
        }
    }
    
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
            make.height.equalTo((KScreenWidth - 20.0*2)*0.65)
        }
        
        newGameBottomView.snp.makeConstraints { make in
            make.top.equalTo(imgV.snp.bottom).offset(10)
            make.left.right.equalTo(newGameTopView)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setModel() {
        if let model = model {
            let url = URL(string: (model.image?.url ?? ""))
            imgV.kf.setImage(with: url, placeholder: nil, options: nil) {[weak self] result in
                guard let self = self else { return }
                self.imgV.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 4.0)
            }
//
        }
    }
}
