//
//  SettingViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import JXSegmentedView
import UIKit

// 个人中心
class SettingViewController: BaseViewController {
    private var pagingView: JXPagingView!
    private var userHeaderView: UserHeaderView!
    private var userHeaderContainerView: UIView!
    private var segmentedViewDataSource: JXSegmentedTitleDataSource!
    private var segmentedView: JXSegmentedView!
    private let titles = ["主页", "发布", "积分"]
    private var JXTableHeaderViewHeight: Int = 250
    private var JXheightForHeaderInSection: Int = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "个人中心"

        userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXTableHeaderViewHeight)))
        userHeaderView = UserHeaderView(frame: userHeaderContainerView.bounds)
        userHeaderContainerView.addSubview(userHeaderView)

        // segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleSelectedColor = UIColor.molaColor
        segmentedViewDataSource.titleNormalColor = UIColor.black
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = true
        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXheightForHeaderInSection)))
        segmentedView.backgroundColor = UIColor.white
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false

        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = UIColor(red: 105 / 255, green: 144 / 255, blue: 239 / 255, alpha: 1)
        lineView.indicatorWidth = 30
        segmentedView.indicators = [lineView]

        let lineWidth = 1 / UIScreen.main.scale
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.lightGray.cgColor
        lineLayer.frame = CGRect(x: 0, y: segmentedView.bounds.height - lineWidth, width: segmentedView.bounds.width, height: lineWidth)
        segmentedView.layer.addSublayer(lineLayer)

        pagingView = JXPagingView(delegate: self)

        view.addSubview(pagingView)

        segmentedView.listContainer = pagingView.listContainerView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.frame = view.bounds
    }
}

extension SettingViewController: JXPagingViewDelegate {
    func tableHeaderViewHeight(in _: JXPagingView) -> Int {
        return JXTableHeaderViewHeight
    }

    func tableHeaderView(in _: JXPagingView) -> UIView {
        return userHeaderContainerView
    }

    func heightForPinSectionHeader(in _: JXPagingView) -> Int {
        return JXheightForHeaderInSection
    }

    func viewForPinSectionHeader(in _: JXPagingView) -> UIView {
        return segmentedView
    }

    func numberOfLists(in _: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        if index == 0 {
            let list = PagingListBaseView()
            list.listViewDidSelectCallback = { _ in
                self.navigationController?.pushViewController(GameDetailViewController(), animated: true)
            }
            list.beginFirstRefresh()
            return list
        } else if index == 1 {
            let list = PagingListBaseView()
            list.listViewDidSelectCallback = { _ in
                self.navigationController?.pushViewController(GameDetailViewController(), animated: true)
            }
            list.beginFirstRefresh()
            return list
        } else {
            let list = MOLAPointsCollectionView()
            list.listViewDidSelectCallback = { _ in
                self.navigationController?.pushViewController(GameDetailViewController(), animated: true)
            }
            return list
        }
    }

    func mainTableViewDidScroll(_: UIScrollView) {
//        userHeaderView?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}
