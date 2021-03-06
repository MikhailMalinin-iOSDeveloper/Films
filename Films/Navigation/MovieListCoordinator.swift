//
//  MovieListCoordinator.swift
//  Films
//
//  Created by iOS_Coder on 11.05.2021.
//

import Foundation
import UIKit

protocol MovieListCoordinatorProtocol: Coordinator {
    func toDetail(for movie: Movie?)
}

final class MovieListCoordinator: MovieListCoordinatorProtocol {
    var navigationController: UINavigationController
    private var moduleBuilder: ModuleBuilderProtocol

    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.moduleBuilder = moduleBuilder
    }

    func start() {
        let movieListViewController = moduleBuilder.createMovieListModule(coordinator: self)
        navigationController.pushViewController(movieListViewController, animated: false)
    }

    func toDetail(for movie: Movie?) {
        let movieDetailsViewController = moduleBuilder.createMovieDetailModule(movie: movie)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
