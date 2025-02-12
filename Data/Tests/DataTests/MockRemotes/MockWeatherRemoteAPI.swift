//
//  MockWeatherRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import NetworkLayer
import Data

final class MockWeatherRemoteAPI: WeatherRemoteAPI {
    
    var mockError: APIError?

    public init(mockError: APIError? = nil) {
        self.mockError = mockError
    }

    func fetchCurrentWeather(cityName: String) async throws -> WeatherDataModel {
        
        if let error = mockError {
            throw error
        }
        
        return weatherDataModel()
    }
}
