//
//  GetWeatherRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import NetworkLayer

/// A protocol that defines a remote API for fetching weather data.
public protocol WeatherRemoteAPI {
    
    /// Fetches the current weather for a given location using a remote API.
    ///
    /// - Parameters:
    ///   - latitude: The latitude of the location as a string.
    ///   - longitude: The longitude of the location as a string.
    /// - Returns: A `WeatherDataModel` object containing the weather data retrieved from the API.
    /// - Throws: An error if the network request fails or data retrieval is unsuccessful.
    func fetchCurrentWeather(latitude: String, longitude: String) async throws -> WeatherDataModel
}

public final class DefaultWeatherRemoteAPI: WeatherRemoteAPI {
    
    private let networkService: NetworkService
    
    // MARK: - Life cycle
    
    /// Initializes the remote API implementation with a network service.
    ///
    /// - Parameter networkService: An instance of `NetworkService` to handle API requests.
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// Fetches the current weather for a given location using the remote API.
    ///
    /// - Parameters:
    ///   - latitude: The latitude of the location as a string.
    ///   - longitude: The longitude of the location as a string.
    /// - Returns: A `WeatherDataModel` object containing the weather data retrieved from the API.
    /// - Throws: An error if the network request fails.
    public func fetchCurrentWeather(
        latitude: String,
        longitude: String
    ) async throws -> WeatherDataModel {
        let result: WeatherDataModel = try await networkService.fetchData(
            from: "lat=\(latitude)&lon=\(longitude)"
        )
        
        return result
    }
}
