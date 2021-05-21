//
//  MovieDetailsDescriptionTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 07.05.2021.
//

import UIKit

final class MovieDetailsDescriptionTableViewCell: UITableViewCell {
    // MARK: - UI properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        addSubview(stackView)
        stackView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 16,
            paddingBottom: 16,
            paddingLeading: 16,
            paddingTrailing: 16
        )
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()

    // MARK: - Init

    init(descriptionText: String?) {
        super.init(style: .default, reuseIdentifier: nil)

        titleLabel.text = "Description"
        descriptionLabel.text = descriptionText
        _ = stackView
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
