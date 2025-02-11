//
//  DefaultWeatherRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

/// The default implementation of `WeatherRepository`, responsible for fetching weather data from a remote API.
public final class DefaultWeatherRepository: WeatherRepository {
    
    // MARK: - Properties
    private let weatherRemoteAPI: WeatherRemoteAPI

    // MARK: - Methods
    
    /// Initializes the repository with a remote API instance.
    ///
    /// - Parameter weatherRemoteAPI: An instance of `WeatherRemoteAPI` used to fetch weather data.
    public init(weatherRemoteAPI: WeatherRemoteAPI) {
        self.weatherRemoteAPI = weatherRemoteAPI
    }

    /// Fetches the current weather for a given location.
    ///
    /// - Parameters:
    /// - cityName: The cityName.
    /// - Returns: A `WeatherItem` containing the transformed weather data.
    /// - Throws: An error if the network request fails.
    public func fetchCurrentWeather(cityName: String) async throws -> WeatherItem {
        let response = try await weatherRemoteAPI.fetchCurrentWeather(cityName: cityName)
      
        return response.toDomain()
    }
}
