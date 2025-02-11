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
    /// to retrieve all `WeatherInfoEntity` objects from Core Data.
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
            let fetchRequest: NSFetchRequest<WeatherInfoEntity> = WeatherInfoEntity.fetchRequest()
            
            // Ensure related CityEntity is fetched
            fetchRequest.relationshipKeyPathsForPrefetching = ["city"]

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
    public func save(
        item: WeatherItem,
        cityName: String,
        cityID: Int
    ) async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()
        
        return await context.perform {
            let city = CityEntity(context: context)
            city.id = Int64(cityID)
            city.name = cityName

            let entity = WeatherInfoEntity(context: context)
            entity.humidity = Int16(item.humidity)
            entity.icon = item.icon
            entity.weatherCondition = item.weatherCondition
            entity.temperatureCelsiusDegree = item.temperatureCelsiusDegree
            entity.temperatureFahrenheitDegree = item.temperatureFahrenheitDegree
            entity.windSpeed = item.windSpeed
            entity.city = city
            
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
    
    /// Deletes all stored `WeatherInfoEntity` objects from Core Data.
    ///
    /// This method creates a new background context, fetches all stored `WeatherInfoEntity` objects,
    /// deletes them, and saves the changes to ensure they are permanently removed.
    ///
    /// The operation is performed asynchronously to avoid blocking the main thread.
    ///
    /// - Logs:
    ///   - `"Cleared all saved items"` if the deletion is successful.
    ///   - `"Failed to clear items: <error>"` if an error occurs.

    public func deleteItem(id: Int) async -> Bool {
        
        let context = persistenceController.container.newBackgroundContext()

        return await context.perform {
            
            let weatherRequest: NSFetchRequest<WeatherInfoEntity> = WeatherInfoEntity.fetchRequest()
            weatherRequest.predicate = NSPredicate(format: "city.id == %d", id)
            
            do {
                let weatherRecords = try context.fetch(weatherRequest)

                // Delete all related WeatherInfoEntity records
                for weather in weatherRecords {
                    context.delete(weather)
                }

                let cityRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
                cityRequest.predicate = NSPredicate(format: "id == %d", id)

                if let city = try context.fetch(cityRequest).first {
                    context.delete(city)
                }

                try context.save()
                
                Logger().info("item deleted")
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
