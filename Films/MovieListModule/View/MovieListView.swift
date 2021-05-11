//
//  MoviesTableView.swift
//  Films
//
//  Created by iOS_Coder on 08.03.2021.
//

import UIKit

protocol MovieListViewDelegate: AnyObject {
    func setupTableViewDelegate() -> UITableViewDelegate
    func setupTableViewDataSource() -> UITableViewDataSource
}

final class MovieListView: UIView {
    // MARK: - VisualComponents

    private(set) var tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Public properties

    weak var delegate: MovieListViewDelegate? {
        didSet {
            setTableViewDelegateAndDataSource()
        }
    }

    // MARK: - Inits

    init() {
        super.init(frame: .zero)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life cycle

    override func layoutSubviews() {
        setTableViewDelegateAndDataSource()

        addSubview(tableView)

        tableView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor
        )
    }

    // MARK: - PrivateMethods

    private func setupView() {
        backgroundColor = .systemBackground

        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.id)
    }

    private func setTableViewDelegateAndDataSource() {
        tableView.delegate = delegate?.setupTableViewDelegate()
        tableView.dataSource = delegate?.setupTableViewDataSource()
    }
}
