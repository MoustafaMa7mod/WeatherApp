//
//  GetWeatherUseCase.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

/// A protocol that defines a use case for fetching weather data.
public protocol GetWeatherUseCase {
    
    /// Executes the use case to fetch the current weather for a given location.
    ///
    /// - Parameters:
    /// - cityName: The cityName.
    /// - Returns: A `WeatherItem` containing the current weather data.
    /// - Throws: An error if the network request fails or data retrieval is unsuccessful.
    func execute(cityName: String) async throws -> WeatherItem
}

/// The default implementation of `GetWeatherUseCase`, which retrieves weather data from a repository.
public final class DefaultGetWeatherUseCase: GetWeatherUseCase {

    // MARK: - Properties
    private let repository: WeatherRepository

    // MARK: - Life cycle
    
    /// Initializes the use case with a weather repository.
    ///
    /// - Parameter repository: An instance of `WeatherRepository` to handle data retrieval.
    public init(repository: WeatherRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    
    /// Executes the use case to fetch the current weather for a given location.
    ///
    /// - Parameters:
    ///   - cityName: The cityName.
    /// - Returns: A `WeatherItem` containing the current weather data.
    /// - Throws: An error if fetching weather data fails.
    public func execute(cityName: String) async throws -> WeatherItem {
        
        try await repository.fetchCurrentWeather(cityName: cityName)
    }
}
