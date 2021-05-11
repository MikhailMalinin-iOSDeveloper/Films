//
//  MoviePosterCollectionViewCell.swift
//  Films
//
//  Created by iOS_Coder on 05.05.2021.
//

import UIKit

final class MoviePosterCollectionViewCell: UICollectionViewCell {
    static let id = "MoviePosterCollectionViewCell"

    // MARK: - VisualComponents

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: - UICollectionViewCell life circle

    override func layoutSubviews() {
        addSubview(imageView)

        imageView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    // MARK: - Public methods

    func setup(with image: UIImage) {
        imageView.image = image
    }
}
