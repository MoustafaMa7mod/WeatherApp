//
//  Untitled.swift
//  WeatherApp
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import Domain
import NetworkLayer

final class MockSearchCountryUseCase: SearchCountryUseCase {
    
    var mockError: APIError?
    
    func execute(name: String) async throws -> [CityItem] {
        
        if let error = mockError {
            throw error
        }
        
        return cityItems()
    }
}
