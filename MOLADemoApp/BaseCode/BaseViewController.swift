//
//  BaseViewController.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/5/19.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self is HomeViewController {
            BaseTabbarController.defaultSingleInstance().isHiddenTabbar = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self is HomeViewController {
            BaseTabbarController.defaultSingleInstance().isHiddenTabbar = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
}
