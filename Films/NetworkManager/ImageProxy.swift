//
//  ImageProxy.swift
//  Films
//
//  Created by iOS_Coder on 12.03.2021.
//

import Foundation

final class ImageProxy: LoadServiceProtocol {
    // MARK: - Private properties

    private let service: LoadServiceProtocol
    var cache: [String: Data] = [:]

    // MARK: - Init

    internal init(service: LoadServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func loadImage(by path: String, completion: @escaping (Data?) -> ()) {
        if let data = cache[path] {
            completion(data as Data)
        } else {
            service.loadImage(by: path) { [weak self] data in
                self?.cache[path] = data
                completion(data)
            }
        }
    }
}
