//
//  GameDetailViewController.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/24.
//

import Foundation
import UIKit


class GameDetailViewController: UIViewController {
    
    private lazy var gameDetailtableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.bgGaryColor
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(GameReplyCell.self, forCellReuseIdentifier: "GameReplyCell")
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()
    
    private lazy var publishView: PublishBottomView = {
        let view = PublishBottomView()
        view.delegate = self
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(gameDetailtableView)
        view.addSubview(publishView)
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 300))
        header.backgroundColor = UIColor.red
        // 设置header
        self.gameDetailtableView.tableHeaderView = header;
        gameDetailtableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(publishView.snp.top)
        }
        
        publishView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-KSafeBottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
}


extension GameDetailViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameReplyCell", for: indexPath) as! GameReplyCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension GameDetailViewController: PublishBottomViewProtocol{
    func publicClick() {
        self.navigationController?.pushViewController(CommentEditViewController(), animated: true)
    }
    
}
