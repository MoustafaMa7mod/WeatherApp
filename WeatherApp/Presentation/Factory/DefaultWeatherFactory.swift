//
//  DefaultWeatherFactory.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 10/02/2025.
//

import Foundation
import Domain
import Data
import NetworkLayer

/// The default implementation of `WeatherFactory`, responsible for creating and managing dependencies.
final class DefaultWeatherFactory: WeatherFactory {

    /// Creates and returns a `GetWeatherUseCase` instance.
    ///
    /// - Returns: A `DefaultGetWeatherUseCase` instance initialized with a `WeatherRepository`.
    func makeGetWeatherUseCase() -> GetWeatherUseCase {
        DefaultGetWeatherUseCase(repository: makeWeatherRepository())
    }
    
    /// Creates and returns a `SearchCountryUseCase` instance.
    ///
    /// - Returns: A `DefaultSearchCountryUseCase` instance initialized with a `SearchCountryRepository`.
    func makeSearchWeatherUseCase() -> SearchCountryUseCase {
        DefaultSearchCountryUseCase(repository: makeSearchWeatherRepository())
    }

    /// Creates and returns a `FavoritesCityLocalUseCase` instance.
    ///
    /// - Returns: A `FavoritesCityLocalUseCase` instance initialized with a `FavoritesCityLocalRepository`.
    func makeFavoritesCityLocalUseCase() -> FavoritesCityLocalUseCase {
        DefaultFavoritesCityLocalUseCase(local: makeFavoritesCityLocalRepository())
    }
}

// MARK: - Weather Use Case Dependency Creation
extension DefaultWeatherFactory {
    
    /// Creates and returns an instance of `WeatherRepository`.
    ///
    /// - Returns: A `DefaultWeatherRepository` instance.
    private func makeWeatherRepository() -> WeatherRepository {
        DefaultWeatherRepository(weatherRemoteAPI: makeWeatherRemoteAPI())
    }
    
    /// Creates and returns an instance of `WeatherRemoteAPI`.
    ///
    /// - Returns: A `DefaultWeatherRemoteAPI` instance.
    private func makeWeatherRemoteAPI() -> WeatherRemoteAPI {
        DefaultWeatherRemoteAPI(
            networkService: makeNetworkService()
        )
    }
    
    /// Creates and returns an instance of `NetworkService` for weather-related API calls.
    ///
    /// - Returns: A `NetworkService` instance configured with the base URL and API key.
    private func makeNetworkService() -> NetworkService {
        NetworkService(
            baseURL: ConfigurationManager.shared.baseUrl,
            apiKey: ConfigurationManager.shared.apiKey
        )
    }
}

// MARK: - Search Country Use Case Dependency Creation
extension DefaultWeatherFactory {
    
    /// Creates and returns an instance of `SearchCountryRepository`.
    ///
    /// - Returns: A `DefaultSearchCountryRepository` instance.
    private func makeSearchWeatherRepository() -> SearchCountryRepository {
        DefaultSearchCountryRepository(
            searchCountryRemoteAPI: makeSearchWeatherRemoteAPI()
        )
    }
    
    /// Creates and returns an instance of `SearchCountryRemoteAPI`.
    ///
    /// - Returns: A `DefaultSearchCountryRemoteAPI` instance.
    private func makeSearchWeatherRemoteAPI() -> SearchCountryRemoteAPI {
        DefaultSearchCountryRemoteAPI(
            networkService: makeNetworkService()
        )
    }
}

// MARK: - Add Favorites City Use Case Dependency Creation
extension DefaultWeatherFactory {
    
    /// Creates and returns an instance of `DefaultFavoritesCityLocalRepository`.
    ///
    /// - Returns: A `DefaultFavoritesCityLocalRepository` instance.
    private func makeFavoritesCityLocalRepository() -> FavoritesCityLocalRepository {
        DefaultFavoritesCityLocalRepository()
    }
}
