//
//  RillaPointsCell.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/10.
//

import UIKit

//积分兑换-商品展示cell
class RillaPointsCell: UICollectionViewCell {
    
    //商品图片
    private lazy var goodsImgV: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    //商品标题
    private lazy var goodsTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    //商品价格
    private lazy var goodsPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.textBlackColor
        return label
    }()
    
    //商品热度
    private lazy var goodsHot: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.textGaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        initUI()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        contentView.addSubview(goodsImgV)
        contentView.addSubview(goodsTitle)
        contentView.addSubview(goodsPrice)
        contentView.addSubview(goodsHot)
        
        goodsImgV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(KScreenWidth/2 - 1 - 20)
            make.height.equalTo(KScreenWidth/2 - 1 - 20).multipliedBy(0.8)
        }
        
        goodsTitle.snp.makeConstraints { make in
            make.top.equalTo(goodsImgV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        goodsPrice.snp.makeConstraints { make in
            make.left.equalTo(goodsTitle.snp.left)
            make.top.equalTo(goodsTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        goodsHot.snp.makeConstraints { make in
            make.right.equalTo(goodsTitle.snp.right)
            make.centerY.equalTo(goodsPrice)
        }
    }
    
    func setModel() {
        let url = URL.init(string: "https://cdn.poizon.com/source-img/origin-img/20201225/503af155eb3c44fd87b404f4fef4707c.jpg?x-oss-process=image/format,webp")
        goodsImgV.kf.setImage(with: url)
        
        goodsTitle.text = "【618推荐】【虞书欣同款】Nike Air Force 1 07 low 空军一号 白色 板鞋 (GS)"
        
        goodsPrice.text = "2000 Rilla"
        
        goodsHot.text = "32145热度"
    }
}
