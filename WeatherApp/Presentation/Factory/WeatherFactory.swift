//
//  WeatherFactory.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Domain
import Data
import NetworkLayer

/// A factory protocol for creating use cases related to weather and country searches.
protocol WeatherFactory {
    
    /// Creates an instance of `GetWeatherUseCase` for fetching weather data.
    ///
    /// - Returns: A `GetWeatherUseCase` instance.
    func makeGetWeatherUseCase() -> GetWeatherUseCase
    
    /// Creates an instance of `SearchCountryUseCase` for searching countries.
    ///
    /// - Returns: A `SearchCountryUseCase` instance.
    func makeSearchWeatherUseCase() -> SearchCountryUseCase
}
