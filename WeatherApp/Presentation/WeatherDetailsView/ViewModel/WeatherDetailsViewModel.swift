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
    var weatherItem: WeatherItem? {
        weatherComponentViewModel?.weatherItem
    }
    
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
                Logger().info("City is already in favorites.")
                // remove from favourtie
                return
            }
            
            await addCityToFavorites(item: weatherItem)
            await reloadView()
        }
    }
    
    func check() {
        
        guard let weatherItem = weatherItem else { return }
        
        Task(priority: .background) {
            
            isFavorite = await isCityInFavorites(id: weatherItem.id)
            
            print("DEBUG: isFavorite \(isFavorite)")
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
            latitude: latitude,
            longitude: longitude
        )
        
//        // Observe weatherItem changes
//        weatherComponentViewModel?.$weatherItem
//            .compactMap { $0 } // Ensures we only get non-nil values
//            .sink { [weak self] _ in
//                Task {
//                    await self?.check()
//                }
//            }
//            .store(in: &cancellable)
    }
    
    /// Adds a city to the favorites list using the local use case.
    ///
    /// - Parameter item: The `WeatherItem` to be added.
    private func addCityToFavorites(item: WeatherItem) async {
        do {
            try await favoritesCityLocalUseCase.addCityToFavorites(item: item)
        } catch {
            Logger().error("Failed to add city to favorites: \(error.localizedDescription)")
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
    
    /// Triggers a UI update after the data has been modified.
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
