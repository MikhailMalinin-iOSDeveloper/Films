//
//  MockMovieNetworkService.swift
//  FilmsTests
//
//  Created by iOS_Coder on 14.05.2021.
//

@testable import Films
import Foundation

final class MockMovieNetworkService: MovieNetworkServiceProtocol {
    private var movies: [Movie]?
    private var photos: [Photo]?

    init() {}

    init(movies: [Movie]) {
        self.movies = movies
    }

    init(photos: [Photo]) {
        self.photos = photos
    }

    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], Error>) -> ()) {
        if let movies = movies {
            completion(.success(movies))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func loadPhotos(for movieId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        if let photos = photos {
            completion(.success(photos))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
