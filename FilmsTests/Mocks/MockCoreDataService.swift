//
//  MockCoreDataService.swift
//  FilmsTests
//
//  Created by iOS_Coder on 14.05.2021.
//

@testable import Films
import Foundation

final class MockCoreDataService: CoreDataServiceProtocol {
    private var movies: [Movie]?

    func save(for category: MovieCategory, movies: [Movie]) {
        self.movies = movies
    }

    func fetch(for category: MovieCategory, completion: ([Movie]?) -> ()) {
        if let movies = movies {
            completion(movies)
        }
    }
}
