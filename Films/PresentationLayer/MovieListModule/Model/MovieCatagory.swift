//
//  MovieCatagory.swift
//  Films
//
//  Created by iOS_Coder on 10.05.2021.
//

import Foundation

/// Movie categories
enum MovieCategory: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular
    case topRated = "top_rated"
    case upcoming

    var caseName: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        case .nowPlaying:
            return "Now playing"
        }
    }
}
