//
//  MovieEntity+CoreDataClass.swift
//  Films
//
//  Created by iOS_Coder on 13.05.2021.
//
//

import CoreData
import Foundation

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {
    static func make(movie: Movie, category: String, in context: NSManagedObjectContext) -> MovieEntity {
        let movieEntity = MovieEntity(context: context)
        movieEntity.id = Int64(movie.id)
        movieEntity.overview = movie.overview
        movieEntity.popularity = movie.popularity
        movieEntity.posterPath = movie.posterPath
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.title = movie.title
        movieEntity.voteAverage = movie.voteAverage
        movieEntity.voteCount = Int64(movie.voteCount)
        movieEntity.category = category
        return movieEntity
    }
}
