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
        if shouldThrowError { throw NSError(domain: "", code: -1) }
        return weatherItemsModel()
    }

    func addCityToFavorites(
        item: WeatherItem,
        cityName: String,
        cityID: Int
    ) async throws -> Bool {
        if shouldThrowError { throw NSError(domain: "", code: -1) }
        return true
    }

    func removeCityFavorites(id: Int) async throws -> Bool {
        removeCityCalled = true
        if shouldThrowError { throw NSError(domain: "", code: -1) }
        return mockRemoveResult
    }
}
