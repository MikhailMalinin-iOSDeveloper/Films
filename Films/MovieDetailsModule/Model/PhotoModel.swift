//
//  PhotoModel.swift
//  Films
//
//  Created by iOS_Coder on 05.05.2021.
//

import Foundation
import RealmSwift

/// PhotoRequestModel
struct PhotoRequestModel: Codable {
    let id: Int
    let backdrops: [Photo]
}

@objcMembers
final class Photo: Object {
    dynamic var filmId = 0
    dynamic var aspectRatio = 0.0
    dynamic var filePath = ""

    override class func primaryKey() -> String? {
        "filePath"
    }
}

extension Photo: Codable {
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
    }
}
