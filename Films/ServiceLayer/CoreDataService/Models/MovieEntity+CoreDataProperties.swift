//
//  MovieEntity+CoreDataProperties.swift
//  Films
//
//  Created by iOS_Coder on 13.05.2021.
//
//

import CoreData
import Foundation

/// MovieEntity
public extension MovieEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged var id: Int64
    @NSManaged var overview: String
    @NSManaged var popularity: Double
    @NSManaged var posterPath: String
    @NSManaged var releaseDate: String
    @NSManaged var title: String
    @NSManaged var voteAverage: Double
    @NSManaged var voteCount: Int64
    @NSManaged var category: String
}

extension MovieEntity: Identifiable {}
