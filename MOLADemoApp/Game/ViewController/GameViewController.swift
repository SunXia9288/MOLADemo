//
//  GameViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit

class GameViewController: BaseViewController {
    
    private lazy var gameTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.bgGaryColor
        tableView.showsVerticalScrollIndicator = false
        tableView.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="游戏"
        view.backgroundColor = UIColor.bgGaryColor
        initUI()
        initFrame()
        initModel()
    }
    
    private func initUI() {
        view.addSubview(gameTableView)
    }
    
    private func initFrame() {
        gameTableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-TabbarSafeHeight)
        }
    }
    
    private func initModel() {
    
    }
}


extension GameViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GameSectionHeadView(frame: CGRect(x: 0, y: 0, width: KScreenWidth - 30, height: 50))
        view.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        view.backgroundColor = UIColor.white
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 20))
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.position = .middle
        }else if indexPath.row == 9{
            cell.position = .last
        }else{
            cell.position = .middle
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PagingViewController(), animated: true)
    }
}
