//
//  NewGameViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.

// 新游
import JXSegmentedView
import UIKit

class NewGameViewController: UIViewController {
    
    static let NewGameTitleCellIdentifier = "NewGameTitleCellIdentifier"
    static let NewGameBannerCellIdentifier = "NewGameBannerCellIdentifier"
    
    private var sectionTitles: [String] = []
    
    private lazy var newGameTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(NewGameTitleCell.classForCoder(), forCellReuseIdentifier: NewGameViewController.NewGameTitleCellIdentifier)
        tableView.register(NewGameBannerCell.classForCoder(), forCellReuseIdentifier: NewGameViewController.NewGameBannerCellIdentifier)
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
        view.addSubview(newGameTableView)
        newGameTableView.backgroundColor = UIColor.bgGaryColor
    }

    func setConstraints() {
        newGameTableView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func setModel() {
        sectionTitles = ["06月01日","06月15日","今天","三天后"]
        
        newGameTableView.reloadData()
    }
}

extension NewGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        label.text = sectionTitles[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section%2 == 0{
            let cell:NewGameBannerCell = tableView.dequeueReusableCell(withIdentifier: NewGameViewController.NewGameBannerCellIdentifier, for:indexPath) as! NewGameBannerCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell:NewGameTitleCell = tableView.dequeueReusableCell(withIdentifier: NewGameViewController.NewGameTitleCellIdentifier, for:indexPath) as! NewGameTitleCell
            cell.selectionStyle = .none
            return cell
        }   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PagingViewController(), animated: true)
    }
}

extension NewGameViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
