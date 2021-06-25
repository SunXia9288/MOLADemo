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
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()

    private lazy var banner: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleToFill
        return imageV
    }()

    private lazy var styleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textBlackColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.molaColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.molaColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()

    public var model: RecommentGameModel? {
        didSet {
            setModel()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.bgGaryColor
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
        bgView.addSubview(styleLabel)
        bgView.addSubview(titleLabel)
        bgView.addSubview(tipsLabel)

        bgView.addSubview(rightView)
        rightView.addSubview(logoLabel)
        rightView.addSubview(scoreLabel)
    }

    func setConstraints() {
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }

        banner.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo((KScreenWidth - 16.0 * 2) * 0.56)
        }

        styleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(banner.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(rightView.snp.left)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(styleLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.right.lessThanOrEqualTo(rightView.snp.left)
        }

        tipsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-15)
            make.right.lessThanOrEqualTo(rightView.snp.left)
        }

        rightView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(((KScreenWidth - 16.0 * 2) * 0.56) / 2)
        }

        logoLabel.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(80)
        }

        scoreLabel.snp.makeConstraints { make in
            make.width.equalTo(logoLabel.snp.width)
            make.centerX.equalTo(logoLabel.snp.centerX)
            make.top.equalTo(logoLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }

    func setModel() {
        guard model != nil else { return }
        let url = URL(string: model!.image?.url ?? "")
        banner.kf.setImage(with: url)

        styleLabel.text = model!.via
        titleLabel.text = model!.title
        if model!.contents == "" {
            if let array = model?.app_summary?.tags?.map({ stu in
                stu.value
            }), array.count > 0 {
                tipsLabel.text = array.joined(separator: " ")
            } else {
                tipsLabel.text = "欢迎来到MOLA世界"
            }

        } else {
            tipsLabel.text = model!.contents
        }

        logoLabel.text = "MOLA"
        scoreLabel.text = model!.rating?.score ?? "5.0"
    }
}
