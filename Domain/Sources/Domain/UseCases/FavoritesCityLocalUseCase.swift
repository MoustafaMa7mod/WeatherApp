//
//  FavoritesCityLocalUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

public protocol FavoritesCityLocalUseCase {
    
    func fetchFavoritesCities() async throws -> [WeatherItem]
    func addCityToFavorites(item: WeatherItem) async throws
    func removeCityFavorites() async throws
}

public final class DefaultFavoritesCityLocalUseCase: FavoritesCityLocalUseCase {

    private let local: FavoritesCityLocalRepository

    public init(local: FavoritesCityLocalRepository) {
        self.local = local
    }

    public func fetchFavoritesCities() async throws -> [WeatherItem] {
        await local.fetchFavoritesCities()
    }
    
    public func addCityToFavorites(item: WeatherItem) async throws {
        await local.save(item: item)
    }
    
    public func removeCityFavorites() async throws {
        await local.clear()
    }
}
