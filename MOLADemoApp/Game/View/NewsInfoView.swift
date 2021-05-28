//
//  NewsInfoView.swift
//  MOLADemoApp
//
//  Created by sun on 2021/5/26.
//

import UIKit

class NewsInfoView: UIView {
    
    let idenContentString = "NewsInfoViewCell"
    var collectViewHeight = 90.0
    
    private var titles: [String] = ["最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦最骚if就哦撒娇哦i肌肤加斯东极；哦","去为i额u日哦呜饿哦i人忘却哦i","v幸存者美女们，想着你，vmxn.v"]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //滚动方向
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: KScreenWidth - 30, height: CGFloat(collectViewHeight))
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(rgb: 0xFFFFFF, alpha: 0.5)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(NewsInfoViewCell.self, forCellWithReuseIdentifier: idenContentString)
        collectionView.layer.cornerRadius = 4   
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(collectViewHeight)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension NewsInfoView: UICollectionViewDelegate{
    
}

extension NewsInfoView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idenContentString, for: indexPath) as! NewsInfoViewCell
        cell.title = titles[indexPath.row]
        return cell
    }
    
    
}
