//
//  MovieDetailsViewController.swift
//  Films
//
//  Created by iOS_Coder on 11.03.2021.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    // MARK: - ViewController life cycle

    override func loadView() {
        let movieDetailsView = MovieDetailsView()
        view = movieDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public methods

    func setupUI(movie: Movie, image: UIImage?) {
        guard let movieDetailsView = view as? MovieDetailsView else { return }

        movieDetailsView.setupUI(movie: movie, image: image)
    }
}
