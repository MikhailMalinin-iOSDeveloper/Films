//
//  ModuleBuilder.swift
//  Films
//
//  Created by iOS_Coder on 04.05.2021.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMovieListModule(coordinator: MovieListCoordinatorProtocol) -> UIViewController
    func createMovieDetailModule(movie: Movie?, coordinator: MovieListCoordinatorProtocol) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    private let networkService = NetworkService()
    private let cacheService = ImagesCacheService()

    func createMovieListModule(coordinator: MovieListCoordinatorProtocol) -> UIViewController {
        let viewController = MovieListViewController()
        let imageProxyService = ImageProxyService(networkService: networkService, cacheService: cacheService)
        let movieListViewModel = MovieListViewModel(networkService: networkService, imageProxy: imageProxyService)
        viewController.inject(viewModel: movieListViewModel)
        viewController.coordinator = coordinator
        return viewController
    }

    func createMovieDetailModule(movie: Movie?, coordinator: MovieListCoordinatorProtocol) -> UIViewController {
        let viewController = MovieDetailsViewController()
        let imageProxyService = ImageProxyService(networkService: networkService, cacheService: cacheService)
        let movieDetailsViewModel = MovieDetailsViewModel(networkService: networkService, imageProxy: imageProxyService)
        viewController.inject(viewModel: movieDetailsViewModel)
        viewController.coordinator = coordinator
        return viewController
    }
}
