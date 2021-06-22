//
//  Const.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/20.
//

import Foundation
@_exported import MJRefresh
@_exported import SnapKit
@_exported import SVProgressHUD
@_exported import Kingfisher


/// 屏幕高度
let KScreenHeight = UIScreen.main.bounds.height
/// 屏幕宽度
let KScreenWidth = UIScreen.main.bounds.width

/// 安全底部高度
let KSafeBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
/// 安全顶部高度
let KSafeTop = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0

/// 导航栏高度
let NavbarHeight = CGFloat(44.0)

/// 包含安全区域的导航栏高度
let NavbarSafeHeight = NavbarHeight + KSafeTop

/// tabbar高度
let TabbarHeight = CGFloat(49.0)

/// 包含安全区域的tabbar高度
let TabbarSafeHeight = TabbarHeight + KSafeBottom


func timeIntervalChangeToTimeStr(timeInterval:TimeInterval, dateFormat:String?) -> String {
      let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
      let formatter = DateFormatter.init()
      if dateFormat == nil {
          formatter.dateFormat = "MM月dd日"
      }else{
          formatter.dateFormat = dateFormat
      }
      return formatter.string(from: date as Date)
}
