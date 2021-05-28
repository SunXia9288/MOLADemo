//
//  PagingViewTableHeaderView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class PagingViewTableHeaderView: UIView {
    var imageView: UIImageView!
    var imageViewFrame: CGRect!
    
    private var gameInfoView: GameInfoView = {
        let view = GameInfoView()
        return view
    }()
    
    private var newsInfoView: NewsInfoView = {
        let view = NewsInfoView()
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x433A39)
        //head顶层
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 200)
        imageView.backgroundColor = UIColor.green
        self.addSubview(imageView)

        imageViewFrame = imageView.frame

        let label = BaseLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "视频 20"
        label.textColor = UIColor.white
        label.layer.backgroundColor =  UIColor.red.cgColor
        label.layer.cornerRadius = 4
        label.autoresizingMask = AutoresizingMask(rawValue: AutoresizingMask.flexibleRightMargin.rawValue | AutoresizingMask.flexibleTopMargin.rawValue)

        self.addSubview(label)
//        frame: CGRect(x: 10, y: frame.size.height - 30, width: 200, height: 30)
        label.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.bottom.equalTo(imageView.snp.bottom).offset(-5)
        }
        
        let label2 = BaseLabel()
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.text = "图片 200"
        label2.textColor = UIColor.white
        label2.layer.backgroundColor =  UIColor.red.cgColor
        label2.layer.cornerRadius = 4
        label2.autoresizingMask = AutoresizingMask(rawValue: AutoresizingMask.flexibleRightMargin.rawValue | AutoresizingMask.flexibleTopMargin.rawValue)
        self.addSubview(label2)
//        frame: CGRect(x: 10, y: frame.size.height - 30, width: 200, height: 30)
        label2.snp.makeConstraints { make in
            make.right.equalTo(label.snp.left).offset(-10)
            make.height.equalTo(20)
            make.bottom.equalTo(imageView.snp.bottom).offset(-5)
        }
        
        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        imageView.kf.setImage(with: url)
        
        
        //head中层
        addSubview(gameInfoView)
        
        gameInfoView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        addSubview(newsInfoView)
        newsInfoView.snp.makeConstraints { make in
            make.top.equalTo(gameInfoView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
    }

    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        if contentOffsetY <= 0 {
            var frame = imageViewFrame!
            frame.size.height -= contentOffsetY
            frame.origin.y = contentOffsetY
            imageView.frame = frame
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
