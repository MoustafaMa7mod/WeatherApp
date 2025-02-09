//
//  WeatherRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

/// A protocol that defines a repository for fetching weather data.
public protocol WeatherRepository {
    
    /// Fetches the current weather for a given location.
    ///
    /// - Parameters:
    ///   - latitude: The latitude of the location as a string.
    ///   - longitude: The longitude of the location as a string.
    /// - Returns: A `WeatherItem` object containing the current weather data.
    /// - Throws: An error if the network request fails or data is invalid.
    func fetchCurrentWeather(latitude: String, longitude: String) async throws -> WeatherItem
}
