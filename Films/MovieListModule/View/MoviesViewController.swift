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

final class MoviesViewController: UIViewController {
    // MARK: - Private properties

    private let moviesView = MoviesView(withCellId: .movieCell)
    private let cellId = "movieCell"
    private var movies: [Movie] = []
    private let imageService = ImageService()
    private lazy var imageProxy = ImageProxy(service: imageService)

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
        NetworkManager().fetchMovies(category: category) { [weak self] movieResponse in
            self?.movies = movieResponse.movies
            DispatchQueue.main.async {
                self?.moviesView.reloadTableView()
            }
        }
    }
}

// MARK: - MoviesViewDelegate

extension MoviesViewController: MoviesViewDelegate {
    func setupTableViewDelegate() -> UITableViewDelegate {
        self
    }

    func setupTableViewDataSource() -> UITableViewDataSource {
        self
    }
}

// MARK: - MoviesTableViewCellDelegate

extension MoviesViewController: MoviesTableViewCellDelegate {
    func getImage(forMovie movie: Movie, completion: @escaping (UIImage?) -> ()) {
        imageProxy.loadImage(by: movie.posterPath) { data in
            if let data = data {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
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

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC = MovieDetailsViewController()
        let movie = movies[indexPath.row]
        if let imageData = imageProxy.cache[movie.posterPath] {
            movieDetailsVC.setupUI(movie: movie, imageData: imageData)
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

extension MoviesViewController: CategoryViewDelegate {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate {
        self
    }

    func setupCollectionViewDataSource() -> UICollectionViewDataSource {
        self
    }
}

// MARK: - UICollectionViewDataSource

extension MoviesViewController: UICollectionViewDataSource {
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

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadData(category: MovieCategory.allCases[indexPath.row])
    }
}
