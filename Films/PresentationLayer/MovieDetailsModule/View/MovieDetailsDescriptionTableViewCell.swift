//
//  MovieDetailsDescriptionTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 07.05.2021.
//

import UIKit

final class MovieDetailsDescriptionTableViewCell: UITableViewCell {
    static let id = "MovieDetailsDescriptionTableViewCell"

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    override func layoutSubviews() {
        addSubview(descriptionLabel)

        descriptionLabel.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }

    func setup(descriptionText: String?) {
        descriptionLabel.text = descriptionText
    }
}
