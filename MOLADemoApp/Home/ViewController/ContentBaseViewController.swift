//
//  ContentBaseViewController.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2018/12/26.
//  Copyright © 2018 jiaxin. All rights reserved.
//

import JXSegmentedView
import UIKit

class ContentBaseViewController: BaseViewController {
    var segmentedDataSource: JXSegmentedTitleDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        JXSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource

        segmentedView.delegate = self
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: KSafeTop, width: view.bounds.size.width, height: 40)
        listContainerView.frame = CGRect(x: 0, y: KSafeTop + 50, width: view.bounds.size.width, height: view.bounds.size.height - (KSafeTop + 50 + TabbarSafeHeight))
    }

    @objc func didSetingsButtonClicked() {}

    @objc func didIndicatorPositionChanged() {
        for indicaotr in segmentedView.indicators as! [JXSegmentedIndicatorBaseView] {
            if indicaotr.indicatorPosition == .bottom {
                indicaotr.indicatorPosition = .top
            } else {
                indicaotr.indicatorPosition = .bottom
            }
        }
        segmentedView.reloadDataWithoutListContainer()
    }
}

extension ContentBaseViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            // 先更新数据源的数据
            dotDataSource.dotStates[index] = false
            // 再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
    }
}

extension ContentBaseViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in _: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            return RecommentViewController()
        } else if index == 1 {
            return NewGameViewController()
        } else if index == 2 {
            return RankingListViewController()
        } else {
            return RecommentViewController()
        }
    }
}
