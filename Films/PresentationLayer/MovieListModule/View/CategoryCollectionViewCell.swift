//
//  CategoryCollectionViewCell.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let id = "CategoryCollectionViewCell"

    // MARK: - Private properties

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.backgroundColor = .systemBackground
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.label.cgColor
        label.layer.masksToBounds = true
        addSubview(label)
        label.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        return label
    }()

    // MARK: - Public Methods

    func setup(text: String) {
        categoryLabel.text = text
    }
}
