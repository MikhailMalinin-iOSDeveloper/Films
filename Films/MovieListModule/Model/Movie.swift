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
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
