//
//  MovieListViewModel.swift
//  Films
//
//  Created by iOS_Coder on 11.05.2021.
//

import Foundation
import UIKit

protocol MovieListViewModelProtocol {
    var movies: [Movie]? { get set }
    var update: (() -> ())? { get set }

    func fetchMovies(for category: MovieCategory)
    func fetchImage(for path: String, completion: @escaping ((Result<UIImage?, Error>) -> ()))
    func toMovieDetail(for indexPath: IndexPath)
}

final class MovieListViewModel: MovieListViewModelProtocol {
    var movies: [Movie]?
    var update: (() -> ())?

    private let networkService: MovieNetworkServiceProtocol
    private let imageProxy: ImageProxyServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    private let coordinator: MovieListCoordinatorProtocol

    init(
        coordinator: MovieListCoordinatorProtocol,
        networkService: MovieNetworkServiceProtocol,
        imageProxy: ImageProxyServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageProxy = imageProxy
        self.coreDataService = coreDataService
    }

    func fetchMovies(for category: MovieCategory) {
        coreDataService.fetch(for: category) { [weak self] movies in
            self?.movies = movies
            self?.update?()
        }

        networkService.fetchMovies(category: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.movies = movies
                self.coreDataService.save(for: category, movies: movies)
                self.update?()
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func fetchImage(for path: String, completion: @escaping ((Result<UIImage?, Error>) -> ())) {
        imageProxy.getImage(by: path) { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func toMovieDetail(for indexPath: IndexPath) {
        coordinator.toDetail(for: movies?[indexPath.row])
    }
}
