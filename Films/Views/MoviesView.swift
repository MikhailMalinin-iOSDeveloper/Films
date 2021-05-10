//
//  MoviesTableView.swift
//  Films
//
//  Created by iOS_Coder on 08.03.2021.
//

import UIKit

protocol MoviesViewDelegate: AnyObject {
    func setupTableViewDelegate() -> UITableViewDelegate
    func setupTableViewDataSource() -> UITableViewDataSource
}

final class MoviesView: UIView {
    // MARK: - VisualComponents

    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Public properties

    weak var delegate: MoviesViewDelegate?

    // MARK: - Inits

    init(withCellId id: MovieCellId) {
        super.init(frame: .zero)

        setupView(withCellId: id)
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
            left: leftAnchor,
            right: rightAnchor
        )
    }

    // MARK: - Public Methods

    func reloadTableView() {
        tableView.reloadData()
    }

    // MARK: - PrivateMethods

    private func setupView(withCellId id: MovieCellId) {
        backgroundColor = .systemBackground

        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: id.rawValue)
    }

    private func setTableViewDelegateAndDataSource() {
        tableView.delegate = delegate?.setupTableViewDelegate()
        tableView.dataSource = delegate?.setupTableViewDataSource()
    }
}
