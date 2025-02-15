//
//  MockFavoritesCityLocalUseCase.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import Foundation

final class MockFavoritesCityLocalUseCase: FavoritesCityLocalUseCase {
    
    var shouldThrowError = false
    var mockRemoveResult = false
    var removeCityCalled = false

    func fetchFavoritesCities() async throws -> [WeatherItem] {
        if shouldThrowError {
            throw NSError(
                domain: "Mock Error",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to fetch FavoritesCities"]
            )
        }
        return weatherItemsModel()
    }

    func addCityToFavorites(
        item: WeatherItem,
        cityName: String,
        cityID: Int
    ) async throws -> Bool {
        if shouldThrowError {
            throw NSError(
                domain: "Mock Error",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to add city to Favorites"]
            )
        }
        return true
    }

    func removeCityFavorites(id: Int) async throws -> Bool {
        removeCityCalled = true
        if shouldThrowError {
            throw NSError(
                domain: "Mock Error",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Failed to remove City from Favorites"]
            )
        }
        return mockRemoveResult
    }
}
