//
//  MovieDetailsView.swift
//  Films
//
//  Created by iOS_Coder on 07.05.2021.
//

import UIKit

protocol MovieDetailsViewDelegate: AnyObject {
    func setupTableViewDelegate() -> UITableViewDelegate
    func setupTableViewDataSource() -> UITableViewDataSource
}

final class MovieDetailsView: UIView {
    // MARK: - VisualComponents

    private(set) var tableView = UITableView()

    // MARK: - Public properties

    weak var delegate: MovieDetailsViewDelegate? {
        didSet {
            setTableViewDelegateAndDataSource()
        }
    }

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        setupTableView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView life circle

    override func layoutSubviews() {
        addSubview(tableView)

        tableView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }

    // MARK: - PrivateMethods

    private func setupTableView() {
        tableView.showsVerticalScrollIndicator = false

        tableView.register(
            MovieDetailsDescriptionTableViewCell.self,
            forCellReuseIdentifier: MovieDetailsDescriptionTableViewCell.id
        )
        tableView.register(
            MovieDetailsPhotosTableViewCell.self,
            forCellReuseIdentifier: MovieDetailsPhotosTableViewCell.id
        )
    }

    private func setTableViewDelegateAndDataSource() {
        tableView.delegate = delegate?.setupTableViewDelegate()
        tableView.dataSource = delegate?.setupTableViewDataSource()
    }
}
