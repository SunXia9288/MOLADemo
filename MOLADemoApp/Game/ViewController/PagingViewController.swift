//
//  PagingViewController.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/8/10.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import JXSegmentedView
import Alamofire
import SwiftyJSON
import HandyJSON
import MJRefresh

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

class PagingViewController: BaseViewController {
    private var pagingView: JXPagingView!
    private var userHeaderView: PagingViewTableHeaderView?
    private var userHeaderContainerView: UIView!
    private var segmentedViewDataSource: JXSegmentedTitleDataSource!
    private var segmentedView: JXSegmentedView!
    private let titles = ["动态", "帖子", "评论"]
    private let titleTypes = ["feed", "topic", "review"]
    private var JXTableHeaderViewHeight: Int = 280
    private var JXheightForHeaderInSection: Int = 50
//    private var list = PagingListBaseView()
    
    private var currentIndex: Int = 0
    
    public var gameModel: GameModel? {
        didSet{
            if let model = gameModel {
                userHeaderView?.model = model
            }
        }
    }
    
    public var feedList: [GameFeedModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "游戏中心"
   
        userHeaderContainerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXTableHeaderViewHeight)))
        userHeaderView = PagingViewTableHeaderView(frame: userHeaderContainerView.bounds)
        userHeaderContainerView.addSubview(userHeaderView!)
        userHeaderView!.model = gameModel
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
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
        lineView.indicatorColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        lineView.indicatorWidth = 30
        segmentedView.indicators = [lineView]

        let lineWidth = 1/UIScreen.main.scale
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.lightGray.cgColor
        lineLayer.frame = CGRect(x: 0, y: segmentedView.bounds.height - lineWidth, width: segmentedView.bounds.width, height: lineWidth)
        segmentedView.layer.addSublayer(lineLayer)

        pagingView = JXPagingView(delegate: self)

        self.view.addSubview(pagingView)
        
//        pagingView.mainTableView.mj_footer = MJRefreshBackNormalFooter() { [weak self] in
//
//        }
        segmentedView.listContainer = pagingView.listContainerView
        
        getGameData()
        getSegmentListData(segmentIndex: currentIndex)
    }
    
    func getGameData() {
        NetWorkRequest(.gameInfo(parameters: ["X-UA" : "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "app_id": gameModel?.id ?? 0])) {[weak self] (responseString) -> (Void) in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = (JSONDeserializer<GameModel>.deserializeFrom(json: json["data"]["app"].description)) { // 从字符串转换为对象实例
                self.gameModel = modelData
            }
        } failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        } errorResult: { () -> (Void) in
            print("网络异常")
        }

    }
    
    func getSegmentListData(segmentIndex: Int) {
        let type = titleTypes[segmentIndex]
        NetWorkRequest(.gameFeedListInfo(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "app_id": gameModel?.id ?? 0 , "type": type])) {[weak self] (responseString) -> (Void) in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = (JSONDeserializer<GameFeedBaseModel>.deserializeFrom(json: json["data"].description)) { // 从字符串转换为对象实例
                self.feedList = modelData.list?.map({ model in
                    return model.data
                }) as? [GameFeedModel]
                self.pagingView.reloadData()
            }
        } failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        } errorResult: { () -> (Void) in
            print("网络异常")
        }
    }
    
    func getSegmentListNextData(segmentIndex: Int) {
        let type = titleTypes[segmentIndex]
        NetWorkRequest(.gameFeedListInfo(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "app_id": gameModel?.id ?? 0 , "type": type, "form": 10, "limit":"10"])) {[weak self] (responseString) -> (Void) in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = (JSONDeserializer<GameFeedBaseModel>.deserializeFrom(json: json["data"].description)) { // 从字符串转换为对象实例
                if let list = modelData.list?.map({ model in
                    return model.data
                }) as? [GameFeedModel]{
                    self.feedList? += list
                    if let view = self.pagingView.listContainerView.validListDict[self.currentIndex]?.listView() as? PagingListBaseView {
                        view.dataSource = self.feedList
                    }
                }
            }
            let view = self.pagingView.listContainerView.validListDict[self.currentIndex]?.listScrollView()
            view?.mj_footer?.endRefreshing()
        } failed: {(failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        } errorResult: {() -> (Void) in
            print("网络异常")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.frame = self.view.bounds
    }
}

extension PagingViewController: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return JXTableHeaderViewHeight
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return userHeaderContainerView
    }

    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return JXheightForHeaderInSection
    }

    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }

    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        currentIndex = index
        let list = PagingListBaseView()
        list.dataSource = self.feedList
        //集成刷新
        list.tableView.mj_footer = MJRefreshBackNormalFooter() { [weak self] in
            self?.getSegmentListNextData(segmentIndex: index)
        }
        list.listViewDidSelectCallback = { indexPath in
            self.navigationController?.pushViewController(GameDetailViewController(), animated: true)
        }
        list.beginFirstRefresh()
        return list
    }

    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        userHeaderView?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}

