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
    init(networkService: NetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol)
    func fetchMovies(for category: MovieCategory)
    func fetchImage(for path: String, completion: @escaping ((Result<UIImage?, Error>) -> ()))
}

final class MovieListViewModel: MovieListViewModelProtocol {
    var movies: [Movie]?
    var update: (() -> ())?

    private let networkService: NetworkServiceProtocol
    private let imageProxy: ImageProxyServiceProtocol

    init(networkService: NetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol) {
        self.networkService = networkService
        self.imageProxy = imageProxy
    }

    func fetchMovies(for category: MovieCategory) {
        networkService.fetchMovies(category: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.movies = movies
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
}
