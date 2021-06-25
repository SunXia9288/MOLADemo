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

    public var model: GameFeedModel? {
        didSet {
            userTopView.model = model
            bottomView.model = model?.app
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

    private func setModel() {
        if let model = model {
            if let imageStr = model.images?.first?.url {
                let url = URL(string: imageStr)
                imgView.kf.setImage(with: url)
            } else {
                imgView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
            titleLabel.text = model.title
        }
    }
}
