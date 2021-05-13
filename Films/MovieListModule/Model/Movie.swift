//
//  Movie.swift
//  Films
//
//  Created by iOS_Coder on 08.03.2021.
//

import Foundation

/// Movie Response
struct MovieResponse: Codable {
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Movie
struct Movie: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(
        id: Int,
        overview: String,
        popularity: Double,
        posterPath: String,
        releaseDate: String,
        title: String,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.id = id
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    init(movieEntity: MovieEntity) {
        id = Int(movieEntity.id)
        overview = movieEntity.overview
        popularity = movieEntity.popularity
        posterPath = movieEntity.posterPath
        releaseDate = movieEntity.releaseDate
        title = movieEntity.title
        voteAverage = movieEntity.voteAverage
        voteCount = Int(movieEntity.voteCount)
    }
}

// enum MovieListModel {
//    case loading
//    case error(_ error: Error)
//    case data(_ data: [MovieModel])
//
//    struct MovieModel {
//        let title: String
//        let photoData: Data?
//        let description: String
//        let rating: Double
//        let date: String
//    }
// }
