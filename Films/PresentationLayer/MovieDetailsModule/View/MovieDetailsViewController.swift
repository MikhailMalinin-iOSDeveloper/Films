//
//  MovieDetailsViewController.swift
//  Films
//
//  Created by iOS_Coder on 11.03.2021.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
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

        setup()
    }

    // MARK: - Public methods

    func inject(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - Private methods

    private func setup() {
        title = viewModel?.movie?.title
        view.backgroundColor = .systemBackground

        updateView()
        viewModel?.setMovie()
    }

    private func updateView() {
        viewModel?.update = { [weak self] in
            self?.movieDetailsView.tableView.reloadData()
        }
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
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MovieDetailsPhotosTableViewCell.id,
                for: indexPath
            ) as? MovieDetailsPhotosTableViewCell
            if let images = viewModel?.imageArray, !images.isEmpty {
                cell?.configure(with: images)
            }
            return cell ?? UITableViewCell()
        case 1:
            return MovieDetailsTitleTableViewCell(
                title: viewModel?.movie?.title ?? "",
                popularity: viewModel?.movie?.popularity ?? 0,
                rating: viewModel?.movie?.voteAverage ?? 0
            )
        case 2:
            return MovieDetailsDescriptionTableViewCell(descriptionText: viewModel?.movie?.overview)
        default:
            break
        }
        return UITableViewCell()
    }
}
