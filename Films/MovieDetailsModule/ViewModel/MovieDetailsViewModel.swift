//
//  MovieDetailsViewModel.swift
//  Films
//
//  Created by iOS_Coder on 11.05.2021.
//

import Foundation
import UIKit

protocol MovieDetailsViewModelProtocol {
    var imageArray: [UIImage?] { get set }
    var movie: Movie? { get set }
    var update: (() -> ())? { get set }
    init(movie: Movie?, networkService: MovieNetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol)

    func setMovie()
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var imageArray: [UIImage?] = []
    var movie: Movie?
    var update: (() -> ())?

    private let networkService: MovieNetworkServiceProtocol
    private let imageProxy: ImageProxyServiceProtocol

    init(movie: Movie?, networkService: MovieNetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol) {
        self.movie = movie
        self.networkService = networkService
        self.imageProxy = imageProxy
    }

    func setMovie() {
        networkService.loadPhotos(for: movie?.id ?? 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photos):
                guard let photos = photos else { return }
                self.getImageData(for: photos)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    private func getImageData(for photos: [Photo]) {
        let photoDispatchGroup = DispatchGroup()

        for photo in photos {
            photoDispatchGroup.enter()

            imageProxy.getImage(by: photo.filePath) { [weak self] result in
                switch result {
                case let .success(image):
                    self?.imageArray.append(image)
                    photoDispatchGroup.leave()
                case let .failure(error):
                    debugPrint(error)
                }
            }
        }

        photoDispatchGroup.notify(queue: .main) {
            self.update?()
        }
    }
}
