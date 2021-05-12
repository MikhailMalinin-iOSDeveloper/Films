//
//  ViewController.swift
//  Films
//
//  Created by iOS_Coder on 04.03.2021.
//

import UIKit

final class MovieListViewController: UIViewController {
    // MARK: - Public properties

    var coordinator: MovieListCoordinatorProtocol?

    // MARK: - Private properties

    private var viewModel: MovieListViewModelProtocol?
    private let moviesView = MovieListView()

    // MARK: - ViewController Life cycle

    override func loadView() {
        moviesView.delegate = self
        view = moviesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Public methods

    func inject(viewModel: MovieListViewModelProtocol, coordinator: MovieListCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }

    // MARK: - Private Methods

    private func setup() {
        title = "Movies"

        viewModel?.fetchMovies(for: .popular)
        updateView()
    }

    private func updateView() {
        viewModel?.update = { [weak self] in
            self?.moviesView.tableView.reloadData()
        }
    }
}

// MARK: - MoviesViewDelegate

extension MovieListViewController: MovieListViewDelegate {
    func setupTableViewDelegate() -> UITableViewDelegate {
        self
    }

    func setupTableViewDataSource() -> UITableViewDataSource {
        self
    }
}

// MARK: - MoviesTableViewCellDelegate

extension MovieListViewController: MovieListTableViewCellDelegate {
    func fetchImage(by path: String, completion: @escaping (UIImage?) -> ()) {
        viewModel?.fetchImage(for: path) { [weak self] result in
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                self?.showError(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieListTableViewCell.id,
            for: indexPath
        ) as? MovieListTableViewCell
        cell?.delegate = self
        cell?.setupCell(movie: viewModel?.movies?[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.toDetail(for: viewModel?.movies?[indexPath.row])
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoryView = CategoryView()
        categoryView.delegate = self
        categoryView.config()
        return categoryView
    }
}

extension MovieListViewController: CategoryViewDelegate {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate {
        self
    }

    func setupCollectionViewDataSource() -> UICollectionViewDataSource {
        self
    }
}

// MARK: - UICollectionViewDataSource

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MovieCategory.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.id,
            for: indexPath
        ) as? CategoryCollectionViewCell
        cell?.setup(text: MovieCategory.allCases[indexPath.row].caseName())
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.fetchMovies(for: MovieCategory.allCases[indexPath.row])
    }
}
