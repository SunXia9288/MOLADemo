//
//  UserHeaderView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/10.
//

import UIKit


//个人中心-tableHeaderView
class UserHeaderView: UIView {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgb: 0x433A39)
        //head顶层
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        let url = URL(string: "https://static-tapad.tapdb.net/MjM5MDk1MkA2MGE4ODI3NmQ4Yjcx.jpg?imageView2/0/w/1280/q/80/format/jpg/interlace/1/ignore-error/1")
        imageView.kf.setImage(with: url)
    }

    //图片下拉放大功能
//    func scrollViewDidScroll(contentOffsetY: CGFloat) {
//        if contentOffsetY <= 0 {
//            var frame = imageViewFrame!
//            frame.size.height -= contentOffsetY
//            frame.origin.y = contentOffsetY
//            imageViewFrame = frame
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
