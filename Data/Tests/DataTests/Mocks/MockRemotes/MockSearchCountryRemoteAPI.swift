//
//  MockSearchCountryRemoteAPI.swift
//  Data
//
//  Created by Mostafa Mahmoud on 12/02/2025.
//

import NetworkLayer
import Data

final class MockSearchCountryRemoteAPI: SearchCountryRemoteAPI {
    
    var mockError: APIError?

    public init(mockError: APIError? = nil) {
        self.mockError = mockError
    }

    func searchCountry(name: String) async throws -> [CityDataModel] {
        
        if let error = mockError {
            throw error
        }
        
        return cityDataModel()
    }
}
