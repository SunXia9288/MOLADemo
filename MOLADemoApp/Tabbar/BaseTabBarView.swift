//
//  BaseTabBarView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit

// 自定义标签栏代理协议
protocol BaseTabBarDelegate {
    func didChooseItem(itemIndex: Int)
}

class BaseTabBarView: UIView {
    var delegate: BaseTabBarDelegate? // 代理,点击item
    var itemArray: [BaseTabBarItem] = [] // 标签Item数组

    init(frame: CGRect, tabbarConfigArr: [[String: String]]) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        let screenW = UIScreen.main.bounds.size.width
        let itemWidth = screenW / CGFloat(tabbarConfigArr.count)

        for (index, itemDic) in tabbarConfigArr.enumerated() {
            let itemFrame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: TabbarHeight)
            // 创建Item视图
            let itemView = BaseTabBarItem(frame: itemFrame, itemDic: itemDic, itemIndex: index)
            addSubview(itemView)
            itemArray.append(itemView)
            // 添加事件点击处理
            itemView.tag = index
            itemView.addTarget(self, action: #selector(didItemClick(item:)), for: UIControl.Event.touchUpInside)
            // 默认点击第一个,即首页
            if index == 0 {
                didItemClick(item: itemView)
            }
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 点击单个标签视图，通过currentSelectState的属性观察器更新标签item的显示
    // 并且通过代理方法切换标签控制器的当前视图控制器
    @objc func didItemClick(item: BaseTabBarItem) {
        for i in 0 ..< itemArray.count {
            let tempItem = itemArray[i]
            if i == item.tag {
                tempItem.currentSelectState = true
            } else {
                tempItem.currentSelectState = false
            }
        }
        // 执行代理方法
        delegate?.didChooseItem(itemIndex: item.tag)
    }
}
