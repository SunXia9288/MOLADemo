//
//  HomeViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import JXSegmentedView
import UIKit

class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
    }

    func initUI() {
        let button = UIButton(type: .custom)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(view)
        }
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }

    @objc func click() {
        let vc = ContentBaseViewController()
        vc.title = "游戏列表"
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = ["关注", "推荐", "即将到来"]
        dataSource.itemWidth = view.bounds.size.width / 3
        dataSource.itemSpacing = 0
        dataSource.isTitleZoomEnabled = true
        dataSource.titleNormalColor = UIColor.normalGaryColor
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
        dataSource.titleSelectedColor = UIColor.textBlackColor
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 18)
        vc.segmentedDataSource = dataSource
        // 配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.isIndicatorWidthSameAsItemContent = true
        vc.segmentedView.indicators = [indicator]

        navigationController?.pushViewController(vc, animated: true)
    }
}
