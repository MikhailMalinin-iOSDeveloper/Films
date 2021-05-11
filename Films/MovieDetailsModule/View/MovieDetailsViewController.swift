//
//  MovieDetailsViewController.swift
//  Films
//
//  Created by iOS_Coder on 11.03.2021.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    // MARK: - Public properties

    weak var coordinator: MovieListCoordinatorProtocol?

    // MARK: - Private properties

    private let movieDetailsView = MovieDetailsView()

    private var viewModel: MovieDetailsViewModelProtocol?

    // MARK: - ViewController life cycle

    override func loadView() {
        movieDetailsView.delegate = self
        view = movieDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public methods

//    func setupUI(movie: Movie) {
//        movieDetailsView
//        movieDetailsView.setupUI(movie: movie, image: image)
//    }

    func inject(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - MovieDetailsViewDelegate

extension MovieDetailsViewController: MovieDetailsViewDelegate {
    func setupTableViewDelegate() -> UITableViewDelegate {
        self
    }

    func setupTableViewDataSource() -> UITableViewDataSource {
        self
    }
}

extension MovieDetailsViewController: UITableViewDelegate {}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDetailsImagesTableViewCell.id,
                for: indexPath
            ) as? MovieDetailsImagesTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDetailsDescriptionTableViewCell.id,
                for: indexPath
            ) as? MovieDetailsDescriptionTableViewCell
            cell?.setup(descriptionText: viewModel?.movie?.overview)
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - MovieDetailsViewDelegate

extension MovieDetailsViewController: MovieDetailsImagesTableViewCellDelegate {
    func setupCollectionViewDelegate() -> UICollectionViewDelegate {
        self
    }

    func setupCollectionViewDataSource() -> UICollectionViewDataSource {
        self
    }
}

// MARK: - UICollectionViewDataSource

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.imageArray.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MoviePosterCollectionViewCell.id,
            for: indexPath
        ) as? MoviePosterCollectionViewCell
        if let image = viewModel?.imageArray[indexPath.row] {
            cell?.setup(with: image)
        }
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension MovieDetailsViewController: UICollectionViewDelegate {}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.bounds.width, height: view.bounds.height / 2)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}
