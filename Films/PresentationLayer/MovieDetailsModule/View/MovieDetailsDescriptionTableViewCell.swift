//
//  MovieDetailsDescriptionTableViewCell.swift
//  Films
//
//  Created by iOS_Coder on 07.05.2021.
//

import UIKit

final class MovieDetailsDescriptionTableViewCell: UITableViewCell {
    static let id = "MovieDetailsDescriptionTableViewCell"

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        addSubview(label)
        label.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingLeading: 10,
            paddingTrailing: 10
        )
        return label
    }()

    func setup(descriptionText: String?) {
        descriptionLabel.text = descriptionText
    }
}
