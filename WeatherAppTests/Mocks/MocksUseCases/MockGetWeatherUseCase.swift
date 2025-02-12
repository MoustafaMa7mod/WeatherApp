//
//  MockGetWeatherUseCase.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import NetworkLayer

final class MockGetWeatherUseCase: GetWeatherUseCase {
    
    var mockError: APIError?
    
    func execute(cityName: String) async throws -> WeatherItem {
        
        if let error = mockError {
            throw error
        }
        
        return weatherItemsModel()
    }
}
