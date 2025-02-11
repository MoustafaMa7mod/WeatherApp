//
//  FavoritesCityLocalRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 11/02/2025.
//

public protocol FavoritesCityLocalRepository {
    func fetchFavoritesCities() async -> [WeatherItem]
    func save(item: WeatherItem) async
    func clear() async
}

