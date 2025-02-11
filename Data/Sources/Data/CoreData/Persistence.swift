//
//  Persistence.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import CoreData
import OSLog

enum CoreDataModel: String {
    case weatherDataApp = "WeatherApp"
}

/// `PersistenceController` is responsible for managing Core Data operations,
/// ensuring thread safety and data consistency.
///
/// This class is implemented as an `actor` to prevent race conditions when accessing Core Data
/// from multiple concurrent tasks, as Swift actors ensure that mutable state is accessed safely.
public actor PersistenceController {

    // MARK: - Properties
    
    /// A shared singleton instance of `PersistenceController`, allowing centralized access
    /// to Core Data operations across the application.
    public static let shared = PersistenceController()

    /// The Core Data persistent container responsible for loading and managing the data model.
    let container: NSPersistentContainer
    
    // MARK: - Initialization

    /// Initializes the Core Data stack with an optional in-memory store for testing purposes.
    ///
    /// - Parameter inMemory: A Boolean flag indicating whether to use an in-memory store.
    ///   Defaults to `false`, meaning data is persisted normally.
    public init(inMemory: Bool = false) {
        
        // Load the Core Data model from the module bundle.
        guard let modelURL = Bundle.module.url(
            forResource: CoreDataModel.weatherDataApp.rawValue,
            withExtension: "momd"
        ), let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to locate Core Data model.")
        }

        // Initialize the persistent container with the loaded model.
        container = NSPersistentContainer(
            name: CoreDataModel.weatherDataApp.rawValue,
            managedObjectModel: managedObjectModel
        )

        // If in-memory storage is requested, use a temporary location.
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Load persistent stores and handle potential errors.
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                Logger().error("Core Data store failed to load: \(error.localizedDescription)")
            }
        }
    }
}

