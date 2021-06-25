//
//  PagingListBaseView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

@objc public class PagingListBaseView: UIView {
    @objc public var tableView: UITableView!
    var dataSource: [GameFeedModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    var listViewDidScrollCallback: ((UIScrollView) -> Void)?
    var listViewDidSelectCallback: ((IndexPath) -> Void)?
    private var isHeaderRefreshed: Bool = false
    deinit {
        listViewDidScrollCallback = nil
        listViewDidSelectCallback = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView = UITableView(frame: frame, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(DynamicCell.self, forCellReuseIdentifier: "DynamicCell")
        addSubview(tableView)
    }

    func beginFirstRefresh() {
        if !isHeaderRefreshed {
            isHeaderRefreshed = true
            tableView.reloadData()
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        tableView.frame = bounds
    }
}

extension PagingListBaseView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if isHeaderRefreshed {
            return dataSource?.count ?? 0
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicCell", for: indexPath) as! DynamicCell
        cell.selectionStyle = .none
        cell.model = dataSource?[indexPath.row]
        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewDidSelectCallback?(indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallback?(scrollView)
    }
}

extension PagingListBaseView: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> Void) {
        listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return tableView
    }
}
