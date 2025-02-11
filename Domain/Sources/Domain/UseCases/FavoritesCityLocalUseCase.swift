//
//  FavoritesCityLocalUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

public protocol FavoritesCityLocalUseCase {
    
    func fetchFavoritesCities() async throws -> [WeatherItem]
    func addCityToFavorites(item: WeatherItem) async throws -> Bool
    func removeCityFavorites(id: Int) async throws -> Bool
}

public final class DefaultFavoritesCityLocalUseCase: FavoritesCityLocalUseCase {

    private let local: FavoritesCityLocalRepository

    public init(local: FavoritesCityLocalRepository) {
        self.local = local
    }

    public func fetchFavoritesCities() async throws -> [WeatherItem] {
        await local.fetchFavoritesCities()
    }
    
    public func addCityToFavorites(item: WeatherItem) async throws -> Bool {
        await local.save(item: item)
    }
    
    public func removeCityFavorites(id: Int) async throws -> Bool {
        await local.clear(id: id)
    }
}
