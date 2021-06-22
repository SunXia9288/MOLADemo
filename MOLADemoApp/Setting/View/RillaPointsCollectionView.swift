//
//  MOLAPointsCollectionView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/10.
//

import UIKit

class MOLAPointsCollectionView: UIView {
    
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    var listViewDidSelectCallback: ((IndexPath) -> ())?
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //滚动方向
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 2
        layout.estimatedItemSize = CGSize(width: KScreenWidth/2, height: KScreenWidth/2)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.bgGaryColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MOLAPointsCell.self, forCellWithReuseIdentifier: "MOLAPointsCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
}

extension MOLAPointsCollectionView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MOLAPointsCell", for: indexPath) as! MOLAPointsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.listViewDidSelectCallback?(indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }
}

extension MOLAPointsCollectionView: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self
    }
    
    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.collectionView
    }
    

}
