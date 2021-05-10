//
//  ImageService.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import Foundation

final class ImageService: LoadServiceProtocol {
    // MARK: - Public Methods

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
