//
//  DefaultFavoritesCityLocalRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 10/02/2025.
//

import OSLog
import CoreData
import Domain

public struct DefaultFavoritesCityLocalRepository: FavoritesCityLocalRepository {
    
    private let persistenceController: PersistenceController
       
    public init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    // MARK: - Core Data Operations

    /// Fetches all favorite cities stored in Core Data and converts them into `WeatherItem` objects.
    ///
    /// This method creates a new background context and performs an asynchronous fetch request
    /// to retrieve all `WeatherCityEntity` objects from Core Data.
    ///
    /// - The fetched entities are mapped to their corresponding `WeatherItem` DTOs using `toDTO()`.
    /// - The operation is executed on a background context to avoid blocking the main thread.
    ///
    /// - Returns: An array of `WeatherItem` objects representing the stored favorite cities.
    ///            Returns an empty array if an error occurs.
    ///
    /// - Logs:
    ///   - `"Failed to fetch weather items: <error>"` if the fetch operation fails.
    public func fetchFavoritesCities() async -> [WeatherItem] {
        let context = persistenceController.container.newBackgroundContext()

        return await context.perform {
            let fetchRequest: NSFetchRequest<WeatherCityEntity> = WeatherCityEntity.fetchRequest()
            do {
                let results = try context
                    .fetch(fetchRequest)
                    .map({ $0.toDTO() })
                return results
            } catch {
                Logger().error("Failed to fetch weather items: \(error.localizedDescription)")
                return []
            }
        }
    }

    /// Saves the current state of the Core Data context.
    ///
    /// This function creates a new background context, performs the save operation,
    /// and ensures that data is persisted safely.
    ///
    /// - Throws: A fatal error if the save operation fails.
    ///
    public func save(item: WeatherItem) async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()
        
        return await context.perform {
            let entity = WeatherCityEntity(context: context)
            entity.id = Int64(item.id)
            entity.cityName = item.cityName
            entity.humidity = Int16(item.humidity)
            entity.icon = item.icon
            entity.temperatureDegree = item.temperatureDegree
            entity.windSpeed = item.windSpeed

            do {
                try context.save()
                Logger().info("item saved")
                return true
            } catch {
                fatalError("""
                           Error save Core Data:
                           \(#file), \(#function), \(error.localizedDescription)
                           """)
            }
        }
    }
    
    /// Deletes all stored `WeatherCityEntity` objects from Core Data.
    ///
    /// This method creates a new background context, fetches all stored `WeatherCityEntity` objects,
    /// deletes them, and saves the changes to ensure they are permanently removed.
    ///
    /// The operation is performed asynchronously to avoid blocking the main thread.
    ///
    /// - Logs:
    ///   - `"Cleared all saved items"` if the deletion is successful.
    ///   - `"Failed to clear items: <error>"` if an error occurs.

    public func clear(id: Int) async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()
        
        return await context.perform {
            let fetchRequest = WeatherCityEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)

            do {
                let objects = try context.fetch(fetchRequest)
                for object in objects {
                    context.delete(object)
                }
                try context.save()
                Logger().info("Deleted \(objects.count) item(s) named \(id)")
                return true
            } catch {
                fatalError("""
                           Error clear Core Data:
                           \(#file), \(#function), \(error.localizedDescription)
                           """)
            }
        }
    }
}
