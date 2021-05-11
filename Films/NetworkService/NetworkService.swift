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
    func loadPhoto(by path: String, completion: @escaping (Result<Data, Error>) -> ())
}

protocol NetworkServiceProtocol: LoadImageServiceProtocol, LoadMoviesServiceProtocol {}

final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private properties

    private let session = URLSession.shared

    private let scheme = "https"
    private let movieHost = "api.themoviedb.org"
    private let imageHost = "image.tmdb.org"
    private let apiKey = "804ca42a0a9aa645433a61786eafd0eb"

    // MARK: - Public methods

    func fetchMovies(category: MovieCategory, completion: @escaping (Result<[Movie], Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = movieHost
        urlComponents.path = "/3/movie/\(category.rawValue)"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = urlComponents.url else { preconditionFailure("Failed to build url") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                do {
                    let movies = try JSONDecoder().decode(MovieResponse.self, from: data).movies
                    DispatchQueue.main.async {
                        completion(.success(movies))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }

        DispatchQueue.global().async {
            task.resume()
        }
    }

    func loadPhotos(for movieId: Int, completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = movieHost
        urlComponents.path = "/\(movieId)/images"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let url = urlComponents.url else { preconditionFailure("Failed to build url") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let photos = try JSONDecoder().decode(PhotoRequestModel.self, from: data).backdrops
                    completion(.success(photos))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        DispatchQueue.global().async {
            task.resume()
        }
    }

    func loadPhoto(by path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = imageHost
        urlComponents.path = "/t/p/w500\(path)"

        guard let url = urlComponents.url else { preconditionFailure("Failed to build url") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }

        DispatchQueue.global().async {
            task.resume()
        }
    }
}
