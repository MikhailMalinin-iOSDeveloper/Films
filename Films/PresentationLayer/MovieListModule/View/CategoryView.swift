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

    private var categoryCollectionView: UICollectionView?

    // MARK: - View life cycle

    override func layoutSubviews() {
        backgroundColor = .systemBackground

        addSubview(categoryCollectionView ?? UICollectionView())

        categoryCollectionView?.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingLeading: 10,
            paddingTrailing: 10
        )
    }

    // MARK: - Public Method

    func config() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 30)
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView?.backgroundColor = .systemBackground
        categoryCollectionView?.showsHorizontalScrollIndicator = false
        setupCollectionView()
    }

    // MARK: - Private methods

    private func setupCollectionView() {
        categoryCollectionView?.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
        )
        categoryCollectionView?.delegate = delegate?.setupCollectionViewDelegate()
        categoryCollectionView?.dataSource = delegate?.setupCollectionViewDataSource()
    }
}
