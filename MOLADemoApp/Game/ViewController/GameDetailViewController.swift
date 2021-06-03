//
//  GameDetailViewController.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/24.
//

import Foundation
import UIKit
import TYAttributedLabel

class GameDetailViewController: UIViewController {
    
    private lazy var scrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        return scrollerView
    }()
    
    private lazy var label1: TYAttributedLabel = {
        let label = TYAttributedLabel()
        return label
    }()
    
    private lazy var label2: TYAttributedLabel = {
        let label = TYAttributedLabel()
        return label
    }()
    
    override func loadView() {
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
    
}
