//
//  DefaultWeatherRepository.swift
//  Data
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation
import Domain

public final class DefaultWeatherRepository: WeatherRepository {
    
    // MARK: - Properties
    private let weatherRemoteAPI: WeatherRemoteAPI

    // MARK: - Methods
    public init(weatherRemoteAPI: WeatherRemoteAPI) {
        self.weatherRemoteAPI = weatherRemoteAPI
    }

    public func fetchCurrentWeather(with url: String) async throws -> WeatherItem {
        let response = try await weatherRemoteAPI.fetchCurrentWeather()
      
        return response.toDomain()
    }
}
