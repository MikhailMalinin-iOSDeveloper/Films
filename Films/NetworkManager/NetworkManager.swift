//
//  NetworkManager.swift
//  Films
//
//  Created by iOS_Coder on 09.03.2021.
//

import Foundation

/// Movie categories
enum MovieCategory: String, CaseIterable {
    case popular
    case topRated = "top_rated"
    case upcoming

    func caseName() -> String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

/// Network Manager
struct NetworkManager {
    // MARK: - Private properties

    private let apiKey = "804ca42a0a9aa645433a61786eafd0eb"

    // MARK: - Public methods

    func fetchMovies(category: MovieCategory, completion: @escaping (MovieResponse) -> ()) {
        let jsonURLString = "https://api.themoviedb.org/3/movie/\(category.rawValue)?api_key=\(apiKey)"

        guard let url = URL(string: jsonURLString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }

            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(movieResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
}
