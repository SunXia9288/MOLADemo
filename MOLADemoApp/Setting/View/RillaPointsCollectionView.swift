//
//  MOLAPointsCollectionView.swift
//  MOLADemoApp
//
//  Created by 夏宗斌 on 2021/6/10.
//

import UIKit

class MOLAPointsCollectionView: UIView {
    var listViewDidScrollCallback: ((UIScrollView) -> Void)?
    var listViewDidSelectCallback: ((IndexPath) -> Void)?
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 滚动方向
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 2
        layout.estimatedItemSize = CGSize(width: KScreenWidth / 2, height: KScreenWidth / 2)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

extension MOLAPointsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MOLAPointsCell", for: indexPath) as! MOLAPointsCell
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listViewDidSelectCallback?(indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listViewDidScrollCallback?(scrollView)
    }
}

extension MOLAPointsCollectionView: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self
    }

    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> Void) {
        listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return collectionView
    }
}
