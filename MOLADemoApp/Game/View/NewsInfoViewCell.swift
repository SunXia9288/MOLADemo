//
//  NewsInfoViewCell.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class NewsInfoViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()

    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initFrame()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initUI() {
        addSubview(titleLabel)
    }

    private func initFrame() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.lessThanOrEqualTo(90)
        }
    }
}
