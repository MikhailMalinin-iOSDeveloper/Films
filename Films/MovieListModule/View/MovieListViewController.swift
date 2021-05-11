//
//  ViewController.swift
//  Films
//
//  Created by iOS_Coder on 04.03.2021.
//

import UIKit

/// Movie Cell Id
enum MovieCellId: String {
    case movieCell
}

final class MovieListViewController: UIViewController {
    // MARK: - Private properties

    private let moviesView = MoviesView(withCellId: .movieCell)
    private let cellId = "movieCell"
    private var movies: [Movie] = []
    private lazy var imageProxy = ImageProxyService(
        networkService: NetworkService(),
        cacheService: ImagesCacheService()
    )

    // MARK: - ViewController Life cycle

    override func loadView() {
        moviesView.delegate = self
        view = moviesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"

        loadData(category: .popular)
    }

    // MARK: - Private Methods

    private func loadData(category: MovieCategory) {
        NetworkService().fetchMovies(category: category) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.moviesView.reloadTableView()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - MoviesViewDelegate

extension MovieListViewController: MoviesViewDelegate {
    func setupTableViewDelegate() -> UITableViewDelegate {
        self
    }

    func setupTableViewDataSource() -> UITableViewDataSource {
        self
    }
}

// MARK: - MoviesTableViewCellDelegate

extension MovieListViewController: MoviesTableViewCellDelegate {
    func getImage(forMovie movie: Movie, completion: @escaping (UIImage?) -> ()) {
        imageProxy.getImage(by: movie.posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                completion(image)
            case let .failure(error):
                self.showError(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MoviesTableViewCell
        cell?.delegate = self
        cell?.setupCell(movie: movies[indexPath.row])
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
        let movieDetailsVC = MovieDetailsViewController()
        let movie = movies[indexPath.row]
        imageProxy.getImage(by: movie.posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(image):
                movieDetailsVC.setupUI(movie: movie, image: image)
            case let .failure(error):
                self.showError(error)
            }
        }
        navigationController?.pushViewController(movieDetailsVC, animated: true)
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
            withReuseIdentifier: CategoryCollectionCellId.categoryCell.rawValue,
            for: indexPath
        ) as? CategoryCollectionViewCell
        cell?.setup(text: MovieCategory.allCases[indexPath.row].caseName())
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadData(category: MovieCategory.allCases[indexPath.row])
    }
}
