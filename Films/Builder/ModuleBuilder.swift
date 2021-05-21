//
//  ModuleBuilder.swift
//  Films
//
//  Created by iOS_Coder on 04.05.2021.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createMovieListModule(coordinator: MovieListCoordinatorProtocol) -> UIViewController
    func createMovieDetailModule(movie: Movie?) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    private let movieNetworkService = MovieNetworkService()
    private let photoNetworkService = PhotoNetworkService()
    private let cacheService = ImagesCacheService()

    func createMovieListModule(coordinator: MovieListCoordinatorProtocol) -> UIViewController {
        let viewController = MovieListViewController()
        let imageProxyService = ImageProxyService(networkService: photoNetworkService, cacheService: cacheService)
        let coreDataService = CoreDataService()
        let movieListViewModel = MovieListViewModel(
            coordinator: coordinator,
            networkService: movieNetworkService,
            imageProxy: imageProxyService,
            coreDataService: coreDataService
        )
        viewController.inject(viewModel: movieListViewModel)
        return viewController
    }

    func createMovieDetailModule(movie: Movie?) -> UIViewController {
        let viewController = MovieDetailsViewController()
        let imageProxyService = ImageProxyService(networkService: photoNetworkService, cacheService: cacheService)
        let movieDetailsViewModel = MovieDetailsViewModel(
            movie: movie,
            networkService: movieNetworkService,
            imageProxy: imageProxyService
        )
        viewController.inject(viewModel: movieDetailsViewModel)
        return viewController
    }
}
