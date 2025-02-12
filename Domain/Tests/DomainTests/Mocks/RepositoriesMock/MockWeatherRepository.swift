//
//  MockWeatherRepository.swift
//  Domain
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import NetworkLayer

class MockWeatherRepository: WeatherRepository {
    
    var error: APIError?

    public init(error: APIError? = nil) {
        self.error = error
    }

    public func fetchCurrentWeather(cityName: String) async throws -> WeatherItem {
        
        if let error = error {
            throw error
        }
    
        return weatherItemModel()
    }
}
