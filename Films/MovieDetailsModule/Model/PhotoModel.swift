//
//  PhotoModel.swift
//  Films
//
//  Created by iOS_Coder on 05.05.2021.
//

import Foundation

/// PhotoRequestModel
struct PhotoRequestModel: Codable {
    let id: Int
    let backdrops: [Photo]
}

/// Photo model
struct Photo: Codable {
    let aspectRatio: Double
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
    }
}

// enum MovieDetailsModel {
//    case loading
//    case error(_ error: Error)
//    case data(data: DetailsModel)
//
//    struct DetailsModel {
//        let title: String
//        let photos: [Data]
//        let description: String
//    }
// }
