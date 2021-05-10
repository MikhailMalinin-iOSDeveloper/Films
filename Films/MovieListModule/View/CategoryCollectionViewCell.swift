//
//  CategoryCollectionViewCell.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.backgroundColor = .systemGray
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()

    // MARK: - View life cycle

    override func layoutSubviews() {
        addSubview(categoryLabel)

        categoryLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
    }

    // MARK: - Public Methods

    func setup(text: String) {
        categoryLabel.text = text
    }
}
