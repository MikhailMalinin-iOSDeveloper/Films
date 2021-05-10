//
//  NetworkManager.swift
//  Films
//
//  Created by iOS_Coder on 09.03.2021.
//

import Foundation

protocol LoadMoviesServiceProtocol {
    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], Error>) -> ())
}

protocol LoadImageServiceProtocol {
    func loadPhotos(for movieId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ())
}

protocol NetworkServiceProtocol: LoadImageServiceProtocol, LoadMoviesServiceProtocol {}

/// Network Manager
struct NetworkService {
    // MARK: - Private properties

    private let apiKey = "804ca42a0a9aa645433a61786eafd0eb"

    // MARK: - Public methods

    func fetchMovies(category: MovieCategory, completion: @escaping (MovieResponse) -> ()) {
        let jsonURLString = "https://api.themoviedb.org/3/movie/\(category.rawValue)?api_key=\(apiKey)"

        guard let url = URL(string: jsonURLString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(movieResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func loadImage(by path: String, completion: @escaping (Data?) -> ()) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadRevalidatingCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)

        var dataTask: URLSessionDataTask?

        let jsonURLString = "https://image.tmdb.org/t/p/w500\(path)"

        guard let url = URL(string: jsonURLString) else { return }

        dataTask = session.dataTask(with: url) { data, _, error in
            dataTask?.cancel()
            defer {
                dataTask = nil
            }

            if let error = error {
                print(error)
            }
            if let data = data {
                completion(data)
            }
        }
        dataTask?.resume()
    }
}
