//
//  MovieDetailsView.swift
//  Films
//
//  Created by iOS_Coder on 10.03.2021.
//

import UIKit

final class MovieDetailsView: UIView {
    // MARK: - Private properties

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private lazy var subViews = [movieImageView, movieNameLabel, movieDescriptionLabel]

    // MARK: - Inits

    init() {
        super.init(frame: .zero)

        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle

    override func layoutSubviews() {
        subViews.forEach { addSubview($0) }

        movieImageView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10,
            height: bounds.height / 2
        )
        movieNameLabel.anchor(
            top: movieImageView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10,
            height: 50
        )
        movieDescriptionLabel.anchor(
            top: movieNameLabel.bottomAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10,
            paddingBottom: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
    }

    // MARK: - Public methods

    func setupUI(movie: Movie, image: UIImage?) {
        movieImageView.image = image
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
    }
}
