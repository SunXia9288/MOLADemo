//
//  DownloadButton.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/22.
//

import UIKit
class DownloadButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.downloadBGColor
        self.setTitle("下载", for: .normal)
        self.setTitleColor(UIColor.downloadTitleColor, for: .normal)
        self.addTarget(self, action: #selector(DownloadClick(_:)), for: .touchUpInside)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.layer.cornerRadius = 4
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    public var model: UriModel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func DownloadClick(_ sender: UIButton) {
        if let apple = model?.apple {
            if let url = URL.init(string: apple) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                SVProgressHUD.showInfo(withStatus: "当前apple该游戏还没有上线AppStore")
            }
        } else {
            SVProgressHUD.showInfo(withStatus: "当前apple该游戏还没有上线AppStore")
        }
        
    }
}
