//
//  MoviesTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 08.03.2021.
//

import UIKit

protocol MoviesTableViewCellDelegate: AnyObject {
    func getImage(forMovie movie: Movie, completion: @escaping (UIImage?) -> ())
}

final class MoviesTableViewCell: UITableViewCell {
    // MARK: - Public properties

    weak var delegate: MoviesTableViewCellDelegate?

    // MARK: - Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let movieRatingLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.4)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()

    private lazy var subViews = [
        movieImageView,
        movieRatingLabel,
        movieNameLabel,
        movieDescriptionLabel,
        movieReleaseDateLabel,
    ]

    // MARK: - View life cycle

    override func layoutSubviews() {
        addSubview(shadowView)
        subViews.forEach { cellView.addSubview($0) }
        shadowView.addSubview(cellView)

        setupSubViewsLayout()
    }

    // MARK: - Public methods

    func setupCell(movie: Movie) {
        movieRatingLabel.text = "\(movie.voteAverage)".uppercased()
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        movieReleaseDateLabel.text = movie.releaseDate
        delegate?.getImage(forMovie: movie) { [weak self] image in
            self?.movieImageView.image = image
        }
    }

    // MARK: - Private methods

    private func setupSubViewsLayout() {
        setBackgroundViewLayout()
        setShadowViewLayout()
        setMovieImageViewLayout()
        setMovieRatingLabelLayout()
        setMovieNameLayout()
        setMovieDescriptionLabelLayout()
        setMovieReleaseDateLabelLayout()
    }

    private func setMovieImageViewLayout() {
        movieImageView.anchor(
            top: cellView.topAnchor,
            bottom: cellView.bottomAnchor,
            left: cellView.leftAnchor,
            width: bounds.width / 3
        )
    }

    private func setMovieRatingLabelLayout() {
        movieRatingLabel.anchor(
            bottom: movieImageView.bottomAnchor,
            right: movieImageView.rightAnchor,
            paddingBottom: 5,
            paddingRight: 5,
            width: 40,
            height: 20
        )
    }

    private func setMovieNameLayout() {
        movieNameLabel.anchor(
            top: cellView.topAnchor,
            left: movieImageView.rightAnchor,
            right: cellView.rightAnchor,
            paddingTop: 5,
            paddingLeft: 10,
            paddingRight: 10,
            height: 20
        )
    }

    private func setMovieDescriptionLabelLayout() {
        movieDescriptionLabel.anchor(
            top: movieNameLabel.bottomAnchor,
            left: movieImageView.rightAnchor,
            right: cellView.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10,
            height: bounds.height * 0.6
        )
    }

    private func setMovieReleaseDateLabelLayout() {
        movieReleaseDateLabel.anchor(
            top: movieDescriptionLabel.bottomAnchor,
            bottom: cellView.bottomAnchor,
            left: movieImageView.rightAnchor,
            right: cellView.rightAnchor,
            paddingBottom: 5,
            paddingLeft: 10,
            paddingRight: 10
        )
    }

    private func setShadowViewLayout() {
        cellView.anchor(
            top: shadowView.topAnchor,
            bottom: shadowView.bottomAnchor,
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor
        )
    }

    private func setBackgroundViewLayout() {
        shadowView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 15,
            paddingLeft: 10,
            paddingRight: 10
        )
    }
}
