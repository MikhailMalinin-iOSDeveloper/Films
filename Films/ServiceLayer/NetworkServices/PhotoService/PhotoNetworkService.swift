//
//  PhotoNetworkService.swift
//  Films
//
//  Created by iOS_Coder on 12.05.2021.
//

import Foundation

protocol PhotoNetworkServiceProtocol {
    func loadPhoto(by path: String, completion: @escaping (Result<Data, Error>) -> ())
}

final class PhotoNetworkService: PhotoNetworkServiceProtocol {
    // MARK: - Private properties

    private let session = URLSession.shared

    private let scheme = "https"
    private let host = "image.tmdb.org"

    // MARK: - Public methods

    func loadPhoto(by path: String, completion: @escaping (Result<Data, Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/t/p/w500\(path)"

        guard let url = urlComponents.url else { preconditionFailure("Failed to build url") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
}
