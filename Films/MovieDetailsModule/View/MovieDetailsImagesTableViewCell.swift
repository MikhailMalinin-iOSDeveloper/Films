//
//  MovieDetailsImagesTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 07.05.2021.
//

import UIKit

protocol MovieDetailsImagesTableViewCellDelegate: AnyObject {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate
    func setupCollectionViewDataSource() -> UICollectionViewDataSource
}

final class MovieDetailsImagesTableViewCell: UITableViewCell {
    static let id = "MovieDetailsImagesTableViewCell"

    // MARK: - VisualComponents

    private(set) var collectionView: UICollectionView?

    // MARK: - Public properties

    weak var delegate: MovieDetailsImagesTableViewCellDelegate? {
        didSet {
            setCollectionViewDelegateAndDataSource()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCollectionView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle

    override func layoutSubviews() {
        backgroundColor = .systemBackground

        addSubview(collectionView ?? UICollectionView())

        collectionView?.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
//            height: (window?.bounds.height ?? 0) / 2
        )
    }

    // MARK: - Private methods

    func setupCollectionView() {
        config()

        collectionView?.register(
            MoviePosterCollectionViewCell.self,
            forCellWithReuseIdentifier: MoviePosterCollectionViewCell.id
        )
    }

    private func config() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .systemBackground
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }

    private func setCollectionViewDelegateAndDataSource() {
        collectionView?.delegate = delegate?.setupCollectionViewDelegate()
        collectionView?.dataSource = delegate?.setupCollectionViewDataSource()
    }
}
