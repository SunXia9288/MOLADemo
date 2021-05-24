//
//  RecommentViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/21.
//

import JXSegmentedView
import UIKit

class RecommentViewController: UIViewController {
    
    static let recCellIdentifier = "GameCardCellIdentifier"
    
    private lazy var recTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(GameCardCell.classForCoder(), forCellReuseIdentifier: RecommentViewController.recCellIdentifier)
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
    }

    func initUI() {
        view.addSubview(recTableView)
        recTableView.backgroundColor = UIColor.bgGaryColor
    }

    func setConstraints() {
        recTableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalTo(view)
        }
    }
}

extension RecommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GameCardCell = tableView.dequeueReusableCell(withIdentifier: RecommentViewController.recCellIdentifier, for:indexPath) as! GameCardCell
        cell.selectionStyle = .none
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
