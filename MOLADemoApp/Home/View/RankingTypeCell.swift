//
//  RankingTypeCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import UIKit

class RankingTypeCell: UICollectionViewCell {
    public var isPitch: Bool = false {
        didSet {
            setModel()
        }
    }

    public var title: String = "" {
        didSet {
            setModel()
        }
    }

    private lazy var typeLabel: BaseLabel = {
        let label = BaseLabel()
        label.layer.cornerRadius = 35 / 2.0
        label.autoresizingMask = AutoresizingMask(rawValue: AutoresizingMask.flexibleRightMargin.rawValue | AutoresizingMask.flexibleTopMargin.rawValue)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {
        contentView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(75)
        }
    }

    func setModel() {
        typeLabel.text = title
        if isPitch {
            typeLabel.layer.backgroundColor = UIColor.pitchGreenColor.cgColor
        } else {
            typeLabel.layer.backgroundColor = UIColor.orange.cgColor
        }
    }
}
