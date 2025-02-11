//
//  FavoritesViewModel.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

import Foundation
import Domain

final class FavoritesViewModel: ObservableObject {
    
    // MARK: - Properties
    private var useCase: FavoritesCityLocalUseCase
    var weatherItemPresentationModel: [WeatherItemPresentationModel] = []

    // MARK: - Methods
    init(useCase: FavoritesCityLocalUseCase) {
        self.useCase = useCase
    }
    
    func onAppear() {
        fetchFavoritesCity()
    }
    
    /// Removes a city from the favorites list asynchronously.
    ///
    /// - Parameter id: The unique identifier of the city to remove.
    ///
    /// This function calls `favoritesCityLocalUseCase.removeCityFavorites(id:)` to remove the city
    /// from the local database. If an error occurs, it logs the error
    func removeCityFromFavorites(id: Int) {
        
        Task(priority: .background) {
            do {
                let result = try await useCase.removeCityFavorites(id: id)
                if result {
                    fetchFavoritesCity()
                }
            } catch {
            }
        }
    }
}

// MARK: - Private Methods
extension FavoritesViewModel {
    
    /// Fetches the list of favorite cities asynchronously and updates the presentation model.
    ///
    /// This function runs on a background thread to prevent blocking the UI.
    /// It retrieves the favorite cities from `useCase.fetchFavoritesCities()` and maps them
    /// into `WeatherItemPresentationModel` for display.
    ///
    /// If an error occurs, it is currently not handled but can be logged or processed later.
    private func fetchFavoritesCity() {
        
        Task(priority: .background) {
            do {
                let result = try await useCase.fetchFavoritesCities()
                weatherItemPresentationModel = result.map { WeatherItemPresentationModel(model: $0)
                }
                await reloadView()
            } catch {
                
            }
        }
    }

    /// Triggers a UI update after the data has been modified.
    @MainActor
    private func reloadView() {
        objectWillChange.send()
    }
}
