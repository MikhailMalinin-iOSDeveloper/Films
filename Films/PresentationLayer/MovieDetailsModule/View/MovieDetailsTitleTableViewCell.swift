//
//  MovieDetailsTitleTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 20.05.2021.
//

import UIKit

final class MovieDetailsTitleTableViewCell: UITableViewCell {
    // MARK: - UI Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popularityStackView, ratingStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var popularityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popularityIcon, popularityLabel])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    private let popularityIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up.arrow.down")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    private let ratingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    // MARK: - Init

    init(title: String, popularity: Double, rating: Double) {
        super.init(style: .default, reuseIdentifier: nil)
        titleLabel.text = title
        popularityLabel.text = String(format: "Popularity %.0f", popularity)
        ratingLabel.text = String(format: "Rating %.1f", rating)
        placeStackView()

        configureComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func placeStackView() {
        contentView.addSubview(stackView)
    }

    private func configureComponents() {
        configureStackView()
        configureDescriptionStackView()
        configurePopularityStackView()
        configureRatingStackView()
    }

    private func configureStackView() {
        stackView.anchor(
            top: contentView.topAnchor,
            bottom: contentView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 16,
            paddingBottom: 16,
            paddingLeading: 16,
            paddingTrailing: 16
        )
    }

    private func configureDescriptionStackView() {
        descriptionStackView.anchor(height: 24)
    }

    private func configurePopularityStackView() {
        popularityIcon.anchor(width: 24, height: 24)
    }

    private func configureRatingStackView() {
        ratingIcon.anchor(width: 24, height: 24)
    }
}
