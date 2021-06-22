//
//  RankingTypeCollectionView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/15.
//

import UIKit

protocol RankingTypeProtocol: AnyObject {
    func didSelectItemAt(index : Int)
}

class RankingTypeCollectionView: UIView {
    
    weak var delegate: RankingTypeProtocol?
    
    static let RankingTypeCellIdentifier = "RankingTypeCellIdentifier"
    
    public var titles: [String] = []
    
    private lazy var index: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //滚动方向
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: 70, height: 35)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.bgGaryColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RankingTypeCell.self, forCellWithReuseIdentifier: RankingTypeCollectionView.RankingTypeCellIdentifier)
        if #available(iOS 13.0, *) {
            collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

extension RankingTypeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingTypeCollectionView.RankingTypeCellIdentifier, for: indexPath) as! RankingTypeCell
        cell.isPitch = (index == indexPath.row)
        cell.title = titles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        self.delegate?.didSelectItemAt(index: indexPath.row)
    }
    
}
