//
//  RankingListViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import JXSegmentedView
import UIKit

class RankingListViewController: UIViewController {
    
    static let RankingListCellIdentifier = "RankingListCellIdentifier"
    
    private lazy var topTypeView: RankingTypeCollectionView = {
        let topTypeView = RankingTypeCollectionView()
        return topTypeView
    }()
    
    private lazy var newGameTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
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
        setModel()
    }

    func initUI() {
        view.addSubview(topTypeView)
        view.addSubview(newGameTableView)
        newGameTableView.backgroundColor = UIColor.bgGaryColor
    }

    func setConstraints() {
        
        topTypeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        newGameTableView.snp.makeConstraints { make in
            make.top.equalTo(topTypeView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setModel() {
        
    }
}

extension RankingListViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RankingListCell = tableView.dequeueReusableCell(withIdentifier: RankingListViewController.RankingListCellIdentifier, for:indexPath) as! RankingListCell
        cell.selectionStyle = .none
        return cell
         
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PagingViewController(), animated: true)
    }
}

extension RankingListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

