//
//  NewGameViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.

import Alamofire
import HandyJSON
// 新游
import JXSegmentedView
import MJRefresh
import SwiftyJSON
import UIKit

class NewGameViewController: UIViewController {
    static let NewBigBannerTitleCellIdentifier = "NewBigBannerTitleCellIdentifier"
    static let NewSmallBannerTitleCellIdentifier = "NewSmallBannerTitleCellIdentifier"

    private var newGameList: [[NewGameModel]] = []

    private var newGameInitialList: [NewGameModel] = []

    private lazy var newGameTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(NewBigBannerTitleCell.classForCoder(), forCellReuseIdentifier: NewGameViewController.NewBigBannerTitleCellIdentifier)
        tableView.register(NewSmallBannerTitleCell.classForCoder(), forCellReuseIdentifier: NewGameViewController.NewSmallBannerTitleCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()

    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()

    private var nextPage: String?

    private var prevPage: String?

    // 临时数据
    private var prevFrom: Int = 0

    private var nextFrom: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setConstraints()
        // loading加载
        loadingShow(vc: self)
        getData()
    }

    func initUI() {
        view.addSubview(newGameTableView)
        newGameTableView.backgroundColor = UIColor.bgGaryColor
        newGameTableView.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            self.getPrevPageData()
        }
        newGameTableView.mj_footer = MJRefreshBackNormalFooter { [weak self] in
            guard let self = self else { return }
            self.getNextPageData()
        }
    }

    func setConstraints() {
        newGameTableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalTo(view)
        }
    }

    func getData() {
        NetWorkRequest(.upComingList(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "action": "refresh"])) { [weak self] responseString -> Void in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = JSONDeserializer<NewGameBaseModel>.deserializeFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.newGameInitialList = list
                    self.newGameList = self.assemblyList(list: list, type: "Next")
                    self.newGameTableView.reloadData()
                }
                self.nextPage = modelData.next_page
                self.prevPage = modelData.prev_page
            }
            self.newGameTableView.mj_header?.endRefreshing()
            self.loadingDismiss(vc: self)
        } failed: { [weak self] failedResutl -> Void in
            guard let self = self else { return }
            print("服务器返回code不为0000啦~\(failedResutl)")
            self.newGameTableView.mj_header?.endRefreshing()
            self.loadingDismiss(vc: self)
        } errorResult: { [weak self] () -> Void in
            guard let self = self else { return }
            print("网络异常")
            self.newGameTableView.mj_header?.endRefreshing()
            self.loadingDismiss(vc: self)
        }
    }

    // 获取上一页 "prev_page": "/webapiv2/upcoming/v1/list?action=refresh&from=0&limit=10&style=0",
    func getPrevPageData() {
        NetWorkRequest(.upComingList(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "action": "refresh", "from": prevFrom, "limit": 10, "style": 0])) { [weak self] responseString -> Void in
            guard let self = self else { return }
            // 游戏列表数据
            var currentModel: NewGameModel?
            let json = JSON(responseString)
            if let modelData = JSONDeserializer<NewGameBaseModel>.deserializeFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.prevFrom += 10
                    currentModel = self.newGameList.first?.first
                    self.newGameInitialList = list + self.newGameInitialList
                    self.newGameList = self.assemblyList(list: self.newGameInitialList, type: "Prev")
                    self.newGameTableView.reloadData()
                    DispatchQueue.main.async {
                        let index = self.getIndexOfNewGameList(model: currentModel)
                        self.newGameTableView.scrollToRow(at: index, at: .top, animated: false)
                    }
                }
                self.nextPage = modelData.next_page
                self.prevPage = modelData.prev_page
                if self.prevPage == "" {
                    self.newGameTableView.mj_header?.isHidden = true
                }
            }
            self.newGameTableView.mj_header?.endRefreshing()
        } failed: { [weak self] failedResutl -> Void in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.newGameTableView.mj_header?.endRefreshing()
        } errorResult: { [weak self] () -> Void in
            print("网络异常")
            self?.newGameTableView.mj_header?.endRefreshing()
        }
    }

    // 获取下一页  "next_page": "/webapiv2/upcoming/v1/list?action=refresh&from=10&limit=10&style=1"
    func getNextPageData() {
        NetWorkRequest(.upComingList(parameters: ["X-UA": "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "action": "refresh", "from": nextFrom, "limit": 10, "style": 1])) { [weak self] responseString -> Void in
            guard let self = self else { return }
            // 游戏列表数据
            var currentModel: NewGameModel?
            let json = JSON(responseString)
            if let modelData = JSONDeserializer<NewGameBaseModel>.deserializeFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.nextFrom += 10
                    currentModel = self.newGameList.last?.last
                    self.newGameInitialList = self.newGameInitialList + list
                    self.newGameList = self.assemblyList(list: self.newGameInitialList, type: "Next")
                    self.newGameTableView.reloadData()
                    DispatchQueue.main.async {
                        let index = self.getIndexOfNewGameList(model: currentModel)
                        self.newGameTableView.scrollToRow(at: index, at: .bottom, animated: false)
                    }
                }
                self.nextPage = modelData.next_page
                self.prevPage = modelData.prev_page
                if self.nextPage == "" {
                    self.newGameTableView.mj_footer?.isHidden = true
                }
            }
            self.newGameTableView.mj_footer?.endRefreshing()
        } failed: { [weak self] failedResutl -> Void in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.newGameTableView.mj_footer?.endRefreshing()
        } errorResult: { [weak self] () -> Void in
            print("网络异常")
            self?.newGameTableView.mj_footer?.endRefreshing()
        }
    }

    // 计算时间重置分组
    func assemblyList(list: [NewGameModel], type: String) -> [[NewGameModel]] {
        var finleList: [[NewGameModel]] = []
        for item in list {
            let time = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(item.event_at), dateFormat: nil)

            if let index = finleList.firstIndex(where: { items in
                let newTime = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(items.first!.event_at), dateFormat: nil)
                return time == newTime
            }) {
                // 存在这样的时间，加入到该时间数组
                if type == "Prev" {
                    // 插入顶部
                    finleList[index].insert(item, at: 0)
                } else {
                    // 插入底部
                    finleList[index].append(item)
                }

            } else {
                // 如果不存在自己创建独立新的数组
                finleList.append([item])
            }
        }
        return finleList
    }

    // 获取某一个数据存在的位置
    func getIndexOfNewGameList(model: NewGameModel?) -> IndexPath {
        var index = IndexPath(row: 0, section: 0)
        for (section, items) in newGameList.enumerated() {
            for (row, item) in items.enumerated() {
                if item.id == model?.id {
                    index = IndexPath(row: row, section: section)
                }
            }
        }

        return index
    }
}

extension NewGameViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return newGameList.count
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 40))
        view.backgroundColor = UIColor.white
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.textBlackColor
        let time = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(newGameList[section].first?.event_at ?? -1), dateFormat: nil)
        // 当前时间
        let nowTime = timeIntervalChangeToTimeStr(timeInterval: Date().timeIntervalSince1970, dateFormat: nil)
        if time == nowTime {
            label.text = "今天"
        } else {
            label.text = time
        }

        return view
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 40
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newGameList[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 判断时间是否为今天
        let model = newGameList[indexPath.section][indexPath.row]
        let time = timeIntervalChangeToTimeStr(timeInterval: TimeInterval(model.event_at), dateFormat: nil)
        // 当前时间
        let nowTime = timeIntervalChangeToTimeStr(timeInterval: Date().timeIntervalSince1970, dateFormat: nil)

        if time == nowTime {
            let cell: NewBigBannerTitleCell = tableView.dequeueReusableCell(withIdentifier: NewGameViewController.NewBigBannerTitleCellIdentifier, for: indexPath) as! NewBigBannerTitleCell
            cell.selectionStyle = .none
            cell.model = newGameList[indexPath.section][indexPath.row]
            return cell
        } else {
            if model.event_at < Int(Date().timeIntervalSince1970) {
                let cell: NewSmallBannerTitleCell = tableView.dequeueReusableCell(withIdentifier: NewGameViewController.NewSmallBannerTitleCellIdentifier, for: indexPath) as! NewSmallBannerTitleCell
                cell.selectionStyle = .none
                cell.model = newGameList[indexPath.section][indexPath.row]
                return cell
            } else {
                let cell: NewBigBannerTitleCell = tableView.dequeueReusableCell(withIdentifier: NewGameViewController.NewBigBannerTitleCellIdentifier, for: indexPath) as! NewBigBannerTitleCell
                cell.selectionStyle = .none
                cell.model = newGameList[indexPath.section][indexPath.row]
                return cell
            }
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PagingViewController()
        vc.gameModel = newGameList[indexPath.section][indexPath.row].app
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewGameViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension NewGameViewController: LoadingViewProtocol {
    func getLoadingView() -> LoadingView {
        return loadingView
    }

    func getErrorView() -> UIView {
        return UIView()
    }
}
