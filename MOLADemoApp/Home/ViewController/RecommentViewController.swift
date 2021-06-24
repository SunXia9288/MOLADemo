//
//  RecommentViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/21.
//

import JXSegmentedView
import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import MJRefresh

class RecommentViewController: UIViewController {
    
    static let recCellIdentifier = "GameCardCellIdentifier"
    
    private var recGameList: [RecommentGameModel] = []
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    private lazy var recTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(GameCardCell.classForCoder(), forCellReuseIdentifier: RecommentViewController.recCellIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()
    
    private var nextPage: String?

    //临时数据
    private var from: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setConstraints()
        //loading加载
        loadingShow(vc: self)
        getData()
        
    }


    func initUI() {
        view.addSubview(recTableView)
        recTableView.backgroundColor = UIColor.bgGaryColor
        recTableView.mj_header = MJRefreshNormalHeader() { [weak self] in
            self?.getData()
        }
        recTableView.mj_footer = MJRefreshBackNormalFooter() { [weak self] in
            self?.getNextpage()
        }
    }

    func setConstraints() {
        recTableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func getData() {
        NetWorkRequest(.gameList(parameters: ["X-UA" : "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213", "action" : "refresh"])) {[weak self] (responseString) -> (Void) in
            guard let self = self else { return }
            // 游戏列表数据
            let json = JSON(responseString)
            if let modelData = (JSONDeserializer<RecommentBaseModel>.deserializeFrom(json: json["data"].description)) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self.recGameList = list
                    self.recTableView.reloadData()
                }
                self.nextPage = modelData.next_page
            }
            self.recTableView.mj_header?.endRefreshing()
            self.loadingDismiss(vc: self)
        } failed: {[weak self] (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.recTableView.mj_header?.endRefreshing()
        } errorResult: {[weak self] () -> (Void) in
            print("网络异常")
            self?.recTableView.mj_header?.endRefreshing()
        }

    }
    
    func getNextpage() {
        NetWorkRequest(.gameList(parameters: ["from" : from, "limit" : 10, "session_id" : "c1087a58-cff3-4191-ac4f-eda3c9213050", "X-UA" : "V=1&PN=WebApp&LANG=zh_CN&VN_CODE=4&VN=0.1.0&LOC=CN&PLT=iOS&DS=iOS&UID=e6bf196b-9724-47e7-9cda-c8485ae04213"])) { [weak self] (responseString) -> (Void) in
            // 游戏列表数据
            
            let json = JSON(responseString)
            if let modelData = (JSONDeserializer<RecommentBaseModel>.deserializeFrom(json: json["data"].description)) { // 从字符串转换为对象实例
                if let list = modelData.list {
                    self?.recGameList += list
                    self?.recTableView.reloadData()
                }
                self?.nextPage = modelData.next_page
                self?.from += 10
            }
            self?.recTableView.mj_footer?.endRefreshing()
        } failed: {[weak self] (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
            self?.recTableView.mj_footer?.endRefreshing()
        } errorResult: {[weak self] () -> (Void) in
            print("网络异常")
            self?.recTableView.mj_footer?.endRefreshing()
        }

    }
}

extension RecommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recGameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GameCardCell = tableView.dequeueReusableCell(withIdentifier: RecommentViewController.recCellIdentifier, for:indexPath) as! GameCardCell
        cell.selectionStyle = .none
        cell.model = self.recGameList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PagingViewController(), animated: true)
    }
}

extension RecommentViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}


extension RecommentViewController: LoadingViewProtocol {
    func getLoadingView() -> LoadingView {
        return loadingView
    }
    
    func getErrorView() -> UIView {
        return UIView()
    }
}
