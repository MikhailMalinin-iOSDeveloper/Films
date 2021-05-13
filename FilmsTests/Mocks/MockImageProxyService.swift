//
//  MockImageProxyService.swift
//  FilmsTests
//
//  Created by iOS_Coder on 14.05.2021.
//

@testable import Films
import UIKit

final class MockImageProxyService: ImageProxyServiceProtocol {
    private var image: UIImage?

    init() {}

    init(image: UIImage?) {
        self.image = image
    }

    func getImage(by path: String?, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        if let image = image {
            completion(.success(image))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
