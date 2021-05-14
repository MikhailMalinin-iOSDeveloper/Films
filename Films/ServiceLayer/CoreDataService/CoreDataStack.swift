//
//  CoreDataStack.swift
//  CoreDataLesson
//
//  Created by iOS_Coder on 06.04.2021.
//

import CoreData

final class CoreDataStack {
    private(set) static var shared = CoreDataStack()

    private let storeIsReady = DispatchGroup()

    private let modelName: String
    private let storeName: String

    private lazy var coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)

    lazy var mainContext: NSManagedObjectContext = {
        storeIsReady.wait()
        do {
            return try DispatchQueue.anywayOnMain {
                let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
                context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
                context.persistentStoreCoordinator = coordinator
                return context
            }
        } catch {
            fatalError("Main context error: \(error)")
        }
    }()

    private lazy var objectModel: NSManagedObjectModel = {
        guard let model = NSManagedObjectModel(contentsOf: objectModelURL) else {
            fatalError("Failure initing MOM from: \(modelName)")
        }
        return model
    }()

    private lazy var objectModelURL: URL = {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        return url
    }()

    private lazy var documentsURL: URL = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }

        return url
    }()

    private init(modelName: String = "CoreData", storeName: String = "Films.sqLite") {
        self.modelName = modelName
        self.storeName = storeName
        registerStore()
    }

    func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()

        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        return context
    }

    func saveToStore() {
        storeIsReady.wait()

        try? DispatchQueue.anywayOnMain {
            guard mainContext.hasChanges else {
                debugPrint("Data hasn't changes")
                return
            }
            do {
                try mainContext.save()
                debugPrint("Data successfully saved to store")
            } catch {
                debugPrint("Data not saved to store with error \(error)")
            }
        }
    }

    private func registerStore() {
        storeIsReady.enter()

        DispatchQueue.global(qos: .background).async {
            let storeURL = self.documentsURL.appendingPathComponent(self.storeName)

            do {
                try self.coordinator.addPersistentStore(
                    ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: storeURL,
                    options: [
                        NSMigratePersistentStoresAutomaticallyOption: true,
                        NSInferMappingModelAutomaticallyOption: true
                    ]
                )

                self.storeIsReady.leave()
            } catch {
                fatalError("Error create store: \(error)")
            }
        }
    }
}
