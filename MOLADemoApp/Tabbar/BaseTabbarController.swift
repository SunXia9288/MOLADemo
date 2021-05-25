//
//  BaseTabbarController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit
import JXSegmentedView

class BaseTabbarController: UITabBarController, BaseTabBarDelegate {
    var tarbarConfigArr: [[String: String]]! // 标签栏配置数组，从Plist文件中读取
    var mainTabBarView: BaseTabbarController!

    var baseTabBarView: BaseTabBarView?
    
    var isHiddenTabbar: Bool {
        didSet {
            baseTabBarView?.isHidden = isHiddenTabbar
        }
    }
    
    //创建一个静态或者全局变量，保存当前单例实例值
    private static let singleInstance = BaseTabbarController()
    
    //提供一个公开的用来去获取单例的方法
    class func defaultSingleInstance() ->BaseTabbarController {
        //返回初始化好的静态变量值
        return singleInstance
    }
    
    override init(nibName _: String?, bundle _: Bundle?) {
        // 1.调用父类的初始化方法
        self.isHiddenTabbar = false
        super.init(nibName: nil, bundle: nil)
        // 2.读取Plist文件,初始化标签栏配置数组
        tarbarConfigArr = getConfigArrFromPlistFile()
        // 3.创建视图控制器
        createControllers()
        // 4.创建自定义TabBarView
        createMainTabBarView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private Methods

    // 读取Tabbar配置文件
    private func getConfigArrFromPlistFile() -> [[String: String]]? {
        let filePath: String? = Bundle.main.path(forResource: "TabBarConfig", ofType: "plist")
        let plistData = NSDictionary(contentsOfFile: filePath ?? "")
        let configArr = plistData?.object(forKey: "Tabbars") as? [[String: String]]
        return configArr
    }

    // 创建视图控制器
    private func createControllers() {
        var controllerNameArray = [String]() // 控制器类名数组
        var controllerTitle = [String]() // 控制器Title数组
        for dictionary in tarbarConfigArr {
            controllerNameArray.append(dictionary["ClassName"]!)
            controllerTitle.append(dictionary["Title"]!)

            guard controllerNameArray.count > 0 else {
                print("error:控制器数组为空")
                return
            }
            // 初始化导航控制器数组
            var nvcArray = [BaseNavigationController]()
            // 在Swift中, 通过字符串创建一个类, 那么必须加上命名空间clsName
            let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            for i in 0 ... controllerNameArray.count - 1 {
                // 动态获取的命名空间是不包含.的, 所以需要我们自己手动拼接
                let anyClass: AnyClass? = NSClassFromString(clsName + "." + controllerNameArray[i])
                // 将AnyClass类型转换为BaseViewController类型，
                // 因为Swift中通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
                if let vcClassType = anyClass as? ContentBaseViewController.Type {
                    let vc = ContentBaseViewController()
                    vc.title = "游戏列表"
                    let dataSource = JXSegmentedTitleDataSource()
                    dataSource.isTitleColorGradientEnabled = true
                    dataSource.titles = ["关注", "推荐", "即将到来"]
                    dataSource.itemWidth = view.bounds.size.width / 3
                    dataSource.itemSpacing = 0
                    dataSource.isTitleZoomEnabled = true
                    dataSource.titleNormalColor = UIColor.normalGaryColor
                    dataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
                    dataSource.titleSelectedColor = UIColor.textBlackColor
                    dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 18)
                    vc.segmentedDataSource = dataSource
                    // 配置指示器
                    let indicator = JXSegmentedIndicatorLineView()
                    indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
                    indicator.isIndicatorWidthSameAsItemContent = true
                    vc.segmentedView.indicators = [indicator]
                    let nav = BaseNavigationController(rootViewController: vc)
                    nvcArray.append(nav)
                }else if let vcClassType = anyClass as? BaseViewController.Type{
                    let viewcontroller = vcClassType.init()
                    viewcontroller.title = controllerTitle[i]
                    let nav = BaseNavigationController(rootViewController: viewcontroller)
                    nvcArray.append(nav)
                }
                
            }
            // 设置标签栏控制器数组
            viewControllers = nvcArray
        }
    }

    // 创建自定义Tabbar
    @available(iOS 11.0, *)
    private func createMainTabBarView() {
        // 1.获取系统自带的标签栏视图的frame,并将其设置为隐藏
        let tabBarRect = tabBar.frame
        tabBar.isHidden = true
        let newTabBarRect = CGRect(x: tabBarRect.origin.x, y: tabBarRect.origin.y - KSafeBottom, width: tabBarRect.size.width, height: tabBarRect.size.height + KSafeBottom)
        // 3.使用得到的frame，和plist数据创建自定义标签栏
        baseTabBarView = BaseTabBarView(frame: newTabBarRect, tabbarConfigArr: tarbarConfigArr!)
        baseTabBarView?.delegate = self
        view.addSubview(baseTabBarView!)
    }

    // MARK: - baseTabBarDelegate

    func didChooseItem(itemIndex: Int) {
        selectedIndex = itemIndex
    }


}
