//
//  MoviesTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 08.03.2021.
//

import UIKit

protocol MovieListTableViewCellDelegate: AnyObject {
    func fetchImage(by path: String, completion: @escaping (UIImage?) -> ())
}

final class MovieListTableViewCell: UITableViewCell {
    static let id = "MovieListTableViewCell"

    // MARK: - Public properties

    weak var delegate: MovieListTableViewCellDelegate?

    // MARK: - Visual Components

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        cellView.addSubview(imageView)
        imageView.anchor(
            top: cellView.topAnchor,
            bottom: cellView.bottomAnchor,
            leading: cellView.leadingAnchor,
            width: bounds.width / 4
        )
        return imageView
    }()

    private lazy var movieRatingLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.4)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        movieImageView.addSubview(label)
        label.anchor(
            bottom: movieImageView.bottomAnchor,
            trailing: movieImageView.trailingAnchor,
            paddingBottom: 5,
            paddingTrailing: 5,
            width: 40,
            height: 20
        )
        return label
    }()

    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        cellView.addSubview(label)
        label.anchor(
            top: cellView.topAnchor,
            leading: movieImageView.trailingAnchor,
            trailing: cellView.trailingAnchor,
            paddingTop: 5,
            paddingLeading: 10,
            paddingTrailing: 10,
            height: 20
        )
        return label
    }()

    private lazy var movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        cellView.addSubview(label)
        label.anchor(
            top: movieNameLabel.bottomAnchor,
            leading: movieImageView.trailingAnchor,
            trailing: cellView.trailingAnchor,
            paddingLeading: 10,
            paddingTrailing: 10,
            height: bounds.height * 0.6
        )
        return label
    }()

    private lazy var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 15)
        cellView.addSubview(label)
        label.anchor(
            top: movieDescriptionLabel.bottomAnchor,
            bottom: cellView.bottomAnchor,
            leading: movieImageView.trailingAnchor,
            trailing: cellView.trailingAnchor,
            paddingBottom: 5,
            paddingLeading: 10,
            paddingTrailing: 10
        )
        return label
    }()

    private lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        shadowView.addSubview(view)
        view.anchor(
            top: shadowView.topAnchor,
            bottom: shadowView.bottomAnchor,
            leading: shadowView.leadingAnchor,
            trailing: shadowView.trailingAnchor
        )
        return view
    }()

    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        addSubview(view)
        view.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 15,
            paddingBottom: 15,
            paddingLeading: 10,
            paddingTrailing: 10
        )
        return view
    }()

    // MARK: - Public methods

    func setupCell(movie: Movie?) {
        movieRatingLabel.text = "\(movie?.voteAverage ?? 0)".uppercased()
        movieNameLabel.text = movie?.title
        movieDescriptionLabel.text = movie?.overview
        movieReleaseDateLabel.text = movie?.releaseDate
        delegate?.fetchImage(by: movie?.posterPath ?? "") { [weak self] image in
            self?.movieImageView.image = image
        }
    }
}
