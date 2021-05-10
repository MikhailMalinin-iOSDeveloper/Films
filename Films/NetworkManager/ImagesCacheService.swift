//
//  PhotoService.swift
//  InContactApp
//
//  Created by iOS_Coder on 14.04.2021.
//

import Foundation
import UIKit

final class ImagesCacheService {
    private let cacheLifetime: TimeInterval = 60 * 60 * 24 * 7

    // MARK: - Helpers

    private static let pathName: String = {
        let pathName = "images"
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cacheDir.appendingPathComponent(pathName, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }

        return pathName
    }()

    private func getFilePath(path: String) -> String? {
        guard let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }

        let hashName = String(describing: path.hashValue)

        return cacheDir.appendingPathComponent(ImagesCacheService.pathName + "/" + hashName).path
    }

    private func saveImageToCache(path: String, image: UIImage) {
        guard let filePath = getFilePath(path: path) else { return }

        let date = image.pngData()

        FileManager.default.createFile(atPath: filePath, contents: date, attributes: nil)
    }

    private func getImageFromCache(path: String) -> UIImage? {
        guard let filename = getFilePath(path: path),
              let info = try? FileManager.default.attributesOfItem(atPath: filename),
              let modificationDate = info[.modificationDate] as? Date else { return nil }

        let lifetime = Date().timeIntervalSince(modificationDate)

        guard lifetime <= cacheLifetime,
              let image = UIImage(contentsOfFile: filename) else { return nil }

        return image
    }

    // MARK: - API

    func getPhoto(
        by path: String,
        runQueue: DispatchQueue,
        completionQueue: DispatchQueue,
        completion: @escaping (UIImage?) -> ()
    ) {
        if let photo = getImageFromCache(path: path) {
            completion(photo)
        } else {
            loadPhoto(by: path, runQueue: runQueue, completionQueue: completionQueue, completion: completion)
        }
    }
}
