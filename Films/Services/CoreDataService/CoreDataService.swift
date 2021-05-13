//
//  CoreDataService.swift
//  Films
//
//  Created by iOS_Coder on 13.05.2021.
//

import CoreData
import Foundation

protocol CoreDataServiceProtocol {
    func save(for category: MovieCategory, movies: [Movie])
    func fetch(for category: MovieCategory, completion: ([Movie]?) -> ())
}

final class CoreDataService: CoreDataServiceProtocol {
    func save(for category: MovieCategory, movies: [Movie]) {
        let privateContext = CoreDataStack.shared.makePrivateContext()

        privateContext.perform {
            do {
                _ = movies.map { MovieEntity.make(movie: $0, category: category.caseName, in: privateContext) }

                try privateContext.save()
            } catch {
                debugPrint("CoreData error saving movies: \(error)")
            }
        }
    }

    func fetch(for category: MovieCategory, completion: ([Movie]?) -> ()) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@", category.caseName)
        let movieEntities = try? CoreDataStack.shared.mainContext.fetch(request)
        completion(movieEntities?.compactMap { Movie(movieEntity: $0) })
    }
}
