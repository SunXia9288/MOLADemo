//
//  LoadingView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/23.
//

import UIKit

class LoadingView: UIView {
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        return loadingView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func loadingViewShow() {
        isHidden = false
        loadingView.startAnimating()
    }

    public func loadingViewdismiss() {
        isHidden = true
        loadingView.stopAnimating()
    }
}
