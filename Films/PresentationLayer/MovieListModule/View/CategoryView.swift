//
//  CategoryView.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import UIKit

/// CategoryViewDelegate
protocol CategoryViewDelegate: AnyObject {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate
    func setupCollectionViewDataSource() -> UICollectionViewDataSource
}

final class CategoryView: UIView {
    // MARK: - Public properties

    weak var delegate: CategoryViewDelegate?

    // MARK: - Private properties

    private var categoryCollectionView: UICollectionView

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 30)
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)

        config()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    func config() {
        backgroundColor = .systemBackground

        addSubview(categoryCollectionView)
        categoryCollectionView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingLeading: 10,
            paddingTrailing: 10
        )
        categoryCollectionView.backgroundColor = .systemBackground
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
        )
        categoryCollectionView.delegate = delegate?.setupCollectionViewDelegate()
        categoryCollectionView.dataSource = delegate?.setupCollectionViewDataSource()
    }
}
