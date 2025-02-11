//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain
import OSLog
import Combine

final class WeatherDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    private var getWeatherUseCase: GetWeatherUseCase
    private var favoritesCityLocalUseCase: FavoritesCityLocalUseCase
    private var cancellable = Set<AnyCancellable>()
    var isFavorite: Bool = false
    var weatherComponentViewModel: WeatherComponentViewModel?
    var weatherItem: WeatherItem?
    
    // MARK: - Methods
    init(
        getWeatherUseCase: GetWeatherUseCase,
        favoritesCityLocalUseCase: FavoritesCityLocalUseCase,
        latitude: String,
        longitude: String
    ) {
        self.getWeatherUseCase = getWeatherUseCase
        self.favoritesCityLocalUseCase = favoritesCityLocalUseCase
        
        initialViewModel(latitude: latitude, longitude: longitude)
        observeWeatherItemChanges()
    }
    
    /// Handles the action when the user taps to add a city to favorites.
    ///
    /// This method ensures that the city is added first, and then the updated list
    /// of favorite cities is fetched.
    func addCityToFavoritesTapped() {
        
        guard let weatherItem = weatherItem else { return }
        
        Task(priority: .background) {
            
            isFavorite = await isCityInFavorites(id: weatherItem.id)
            
            guard !isFavorite else {
                isFavorite = !(await removeCityFromFavorites(id: weatherItem.id))
                await reloadView()
                return
            }
            
            isFavorite = await addCityToFavorites(item: weatherItem)
            await reloadView()
        }
    }
}

// MARK: - Private Methods
extension WeatherDetailsViewModel {

    /// Initializes the weather component view model with the given location.
    ///
    /// - Parameters:
    ///   - latitude: The latitude of the location.
    ///   - longitude: The longitude of the location.
    private func initialViewModel(
        latitude: String,
        longitude: String
    ) {
        
        weatherComponentViewModel = WeatherComponentViewModel(
            useCase: getWeatherUseCase,
            delegate: WeatherComponentViewModelDelegate(),
            latitude: latitude,
            longitude: longitude
        )
    }
    
    /// Observes changes to the `weatherItem` property in `weatherComponentViewModel`
    /// and triggers a check to see if the city is in the favorites list.
    ///
    /// This function sets up a Combine subscription to listen for updates to
    /// `weatherItem` via its `@Published` property. When `weatherItem` is updated,
    /// it extracts the non-nil value and calls `checkCityInFavorites(id:)` to verify
    /// if the city is in the favorites.
    ///
    /// - Important: This method ensures that only non-nil values of `weatherItem`
    ///   are processed, preventing unnecessary operations.
    /// - Note: Uses `[weak self]` to prevent retain cycles.
    ///
    /// Example Usage:
    /// ```
    /// observeWeatherItemChanges()
    /// ```
    private func observeWeatherItemChanges() {
        
        weatherComponentViewModel?
            .delegate?
            .$weatherItem
            .compactMap { $0 } // Ensures we only get non-nil values
            .sink { [weak self] item in
                guard let self else { return }
                self.weatherItem = item
                self.checkCityInFavorites(id: item.id)
            }
            .store(in: &cancellable)
    }
    
    /// Adds a city to the favorites list using the local use case.
    ///
    /// - Parameter item: The `WeatherItem` to be added.
    private func addCityToFavorites(item: WeatherItem) async -> Bool {
        do {
            return try await favoritesCityLocalUseCase.addCityToFavorites(item: item)
        } catch {
            Logger().error("Failed to add city to favorites: \(error.localizedDescription)")
            return false
        }
    }
    
    /// Removes a city from the favorites list asynchronously.
    ///
    /// - Parameter id: The unique identifier of the city to remove.
    /// - Returns: `true` if the city was successfully removed, otherwise `false`.
    ///
    /// This function calls `favoritesCityLocalUseCase.removeCityFavorites(id:)` to remove the city
    /// from the local database. If an error occurs, it logs the error and returns `false`.
    private func removeCityFromFavorites(id: Int) async -> Bool {
        do {
            return try await favoritesCityLocalUseCase.removeCityFavorites(id: id)
        } catch {
            Logger().error("Failed to add city to favorites: \(error.localizedDescription)")
            return false
        }
    }
    
    /// Checks if a city with the given `id` exists in the favorites list.
    ///
    /// - Parameter id: The unique identifier of the city.
    /// - Returns: `true` if the city exists in favorites, otherwise `false`.
    private func isCityInFavorites(id: Int) async -> Bool {
        do {
            let result = try await favoritesCityLocalUseCase.fetchFavoritesCities()
            return result.contains { $0.id == id }
        } catch {
            Logger().error("Failed to fetch favorite cities: \(error.localizedDescription)")
            return false
        }
    }
    
    /// Checks if a city is in the favorites list and updates the `isFavorite` property accordingly.
    ///
    /// - Parameter id: The unique identifier of the city to check.
    ///
    /// This function runs asynchronously on a background thread to avoid blocking the main thread.
    /// It calls `isCityInFavorites(id:)` to determine whether the city exists in the favorites list
    /// and then updates the UI by calling `reloadView()`.
    private func checkCityInFavorites(id: Int) {
                
        Task(priority: .background) {
            
            isFavorite = await isCityInFavorites(id: id)
            await reloadView()
        }
    }
    
    /// Triggers a UI update after the data has been modified.
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
