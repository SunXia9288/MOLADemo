//
//  RankingListViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import Alamofire
import HandyJSON
import JXSegmentedView
import MJRefresh
import SwiftyJSON
import UIKit

class RankingListViewController: UIViewController {
    static let RankingListCellIdentifier = "RankingListCellIdentifier"

    private var rankingList: [GameModel] = []

    private var nextPage: String?

    private var typeList = ["hot", "reserve", "pop", "new"]

    private var typeTitleList = ["热门", "预约", "热玩", "新品"]

    private var nextFrom: Int = 15

    private var currentIndex: Int = 0 {
        didSet {
            getData()
        }
    }

    private lazy var topTypeView: RankingTypeCollectionView = {
        let topTypeView = RankingTypeCollectionView()
        topTypeView.titles = typeTitleList
        topTypeView.delegate = self
        return topTypeView
    }()

    private lazy var rankingTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(RankingListCell.classForCoder(), forCellReuseIdentifier: RankingListViewController.RankingListCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setConstraints()
        getData()
    }

    func initUI() {
        view.addSubview(topTypeView)
        view.addSubview(rankingTableView)
        rankingTableView.backgroundColor = UIColor.bgGaryColor

        rankingTableView.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            self.getData()
        }
        rankingTableView.mj_footer = MJRefreshBackNormalFooter { [weak self] in
            guard let self = self else { return }
            self.getNextPageData()
        }
    }

    func setConstraints() {
        topTypeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        rankingTableView.snp.makeConstraints { make in
            make.top.equalTo(topTypeView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func getData() {
        NetWorkRequest(.rankingList(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "platform": "ios", "type_name": typeList[currentIndex]])) { [weak self] responseString -> Void in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = JSONDeserializer<RankingBaseModel>.deserializeFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.rankingList = list
                    self.rankingTableView.reloadData()
                    DispatchQueue.main.async {
                        self.rankingTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
                self.nextPage = modelData.next_page
            }
            self.rankingTableView.mj_header?.endRefreshing()
        } failed: { [weak self] failedResutl -> Void in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.rankingTableView.mj_header?.endRefreshing()
        } errorResult: { [weak self] () -> Void in
            print("网络异常")
            self?.rankingTableView.mj_header?.endRefreshing()
        }
    }

    func getNextPageData() {
        NetWorkRequest(.rankingList(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "platform": "ios", "type_name": typeList[currentIndex], "from": nextFrom, "limit": 15])) { [weak self] responseString -> Void in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = JSONDeserializer<RankingBaseModel>.deserializeFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.nextFrom += 15
                    self.rankingList += list
                    self.rankingTableView.reloadData()
                }
                self.nextPage = modelData.next_page
            }
            self.rankingTableView.mj_footer?.endRefreshing()
        } failed: { [weak self] failedResutl -> Void in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.rankingTableView.mj_footer?.endRefreshing()
        } errorResult: { [weak self] () -> Void in
            print("网络异常")
            self?.rankingTableView.mj_footer?.endRefreshing()
        }
    }
}

extension RankingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return rankingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RankingListCell = tableView.dequeueReusableCell(withIdentifier: RankingListViewController.RankingListCellIdentifier, for: indexPath) as! RankingListCell
        cell.selectionStyle = .none
        cell.type = typeList[currentIndex]
        cell.model = rankingList[indexPath.row]
        cell.row = indexPath.row + 1
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PagingViewController()
        vc.gameModel = rankingList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RankingListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension RankingListViewController: RankingTypeProtocol {
    func didSelectItemAt(index: Int) {
        currentIndex = index
    }
}
