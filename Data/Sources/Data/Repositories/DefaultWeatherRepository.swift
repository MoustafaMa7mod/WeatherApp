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
    ///   - latitude: The latitude of the location as a string.
    ///   - longitude: The longitude of the location as a string.
    /// - Returns: A `WeatherItem` containing the transformed weather data.
    /// - Throws: An error if the network request fails.
    public func fetchCurrentWeather(
        latitude: String,
        longitude: String
    ) async throws -> WeatherItem {
        let response = try await weatherRemoteAPI.fetchCurrentWeather(
            latitude: latitude,
            longitude: longitude
        )
      
        return response.toDomain()
    }
}
