//
//  AppDelegate.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import UIKit
import SVProgressHUD
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = BaseTabbarController.defaultSingleInstance()
        window?.makeKeyAndVisible()
        return true
    }
}
