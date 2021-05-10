//
//  ImageProxy.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import Foundation
import UIKit

protocol ImageProxyServiceProtocol {
    func getImage(by path: String, completion: @escaping (Result<UIImage?, Error>) -> ())
}

final class ImageProxyService: ImageProxyServiceProtocol {
    // MARK: - Private properties

    private let networkService: LoadImageServiceProtocol
    private let cacheService: ImagesCacheServiceProtocol

    // MARK: - Init

    internal init(networkService: LoadImageServiceProtocol, cacheService: ImagesCacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    // MARK: - Public Methods

    func getImage(by path: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        if let image = cacheService.getImageFromCache(path: path) {
            completion(.success(image))
            return
        }

        networkService.loadPhoto(by: path) { [weak self] result in
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else { return }
                self?.cacheService.saveImageToCache(path: path, image: image)
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
