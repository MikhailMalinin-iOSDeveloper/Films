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
    init(networkService: NetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol)

    func setMovie()
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var imageArray: [UIImage?] = []
    var movie: Movie?
    var update: (() -> ())?

    private let networkService: NetworkServiceProtocol
    private let imageProxy: ImageProxyServiceProtocol

    init(networkService: NetworkServiceProtocol, imageProxy: ImageProxyServiceProtocol) {
        self.networkService = networkService
        self.imageProxy = imageProxy
    }

    func setMovie() {}
}
