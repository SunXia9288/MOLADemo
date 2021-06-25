//
//  NewSmallBannerTitleCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

// banner+ 游戏信息
import UIKit

class NewSmallBannerTitleCell: UITableViewCell {
    private lazy var banner: UIImageView = {
        let imgv = UIImageView()
        imgv.clipsToBounds = true
        imgv.layer.cornerRadius = 8.0
        imgv.contentMode = .scaleAspectFill
        return imgv
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textBlackColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private lazy var tagButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textGaryColor
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    public var model: NewGameModel? {
        didSet {
            setModel()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        setModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        contentView.addSubview(banner)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagButton)
        contentView.addSubview(descriptionLabel)

        banner.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(142)
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(banner)
            make.left.equalTo(banner.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }

        tagButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tagButton.snp.bottom)
            make.left.right.equalTo(titleLabel)
        }
    }

    func setModel() {
        if let model = model {
            let url = URL(string: model.image?.url ?? "")
            banner.kf.setImage(with: url)

            titleLabel.text = model.app?.title
            tagButton.setTitle(model.type_label, for: .normal)
            descriptionLabel.text = model.rec_text

            if model.type_label == "首发" {
                tagButton.setTitleColor(UIColor.lightRedColor, for: .normal)
            } else {
                tagButton.setTitleColor(UIColor.downloadTitleColor, for: .normal)
            }
        }
    }
}
